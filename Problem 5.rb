require "csv"
require 'time'

def parse_event_dates (file_name)
  begin #Basic error handling for wrong path of file names
    file= CSV.read(file_name)
  rescue
    return file_name
  end

  date_regex= Regexp.new(/((?<=[\s,.-])?\d{1,2})[\/-](\d{1,2})[\/-](\d+)\s+(?<=[\s,.-])((\d{1,2}):(\d{1,2}):(\d{1,2}))/)
  valid= []
  invalid= []

  line=1;
  file.each do |event, date|
    valid_date= date_regex.match(date)
    begin
      raise if !valid_date #Wrong date format

      year= valid_date[3]
      year= year.length < 4 ? "0" * (4-year.length) + year : year;

      month= valid_date[2]
      day= valid_date[1]
      time= valid_date[4]

      date= Time.parse("#{year}-#{month}-#{day} #{time} +0000") #If date is not valid an exception is raised, and saved in the invalid array

      ENV['TZ']= "EST"
        valid << [event, Time.at(date.to_i)]; #Date is valid and converted to EST
      ENV['TZ']= nil

    rescue
      invalid << [line, event, date]
    end
    line+=1
  end

  valid.sort! {|first, second| first[1].to_i <=> second[1].to_i} #Sorting from earliest to latest
  return {"valid"=> valid, "invalid"=> invalid}
end

def format(date) #Used to output the correct time format for the Valid events .csv file
    time= /\d{1,2}:\d{1,2}:\d{1,2}/.match(date.to_s)[0];
    day= date.day <10 ? "0"+ date.day.to_s : date.day;
    month=  date.month <10 ? "0"+date.month.to_s : date.month;
    return {"time"=> time, "day"=> day, "month"=>month }
end

def valid_and_invalid_to_CSV (dates)
  valid= dates["valid"]
  invalid= dates["invalid"]

  CSV.open("./Files/Valid Dates.csv", "w") do |file|
    file << ["Event", "Date"]
    valid.each do |event, date|
      time, day, month= format(date).values_at("time", "day", "month")
      file << [event, "#{day}/#{month}/#{date.year} #{time}"]
    end
    file << ["\n\n"]
    file << ["Valid VS Invalid Date Chart"]
    file << [ "Valid  : #{valid.length}", "#{"="*valid.length}",]
    file << [ "Invalid: #{invalid.length}", "#{"="*invalid.length}"]
  end

  CSV.open("./Files/Invalid Dates.csv", "w") do |file|
    file << ["Line", "Event", "Date"]
    invalid.each{|line, event, date| file << [line, event, date]}
  end
end

events_info= parse_event_dates("./Files/events.csv")

String===events_info ? (p "Error reading the file: #{events_info}") : valid_and_invalid_to_CSV(events_info)


