def format_file ()
  formated=""
  File.open("./Files/strings.txt") do |file|
    regex=  Regexp.new(/(\s+)|(\\+[ntr])|(\w+\s+\.|\s+\w+)|(\.)/)
    while line= file.gets
      while match= regex.match(line)
        finish= match.offset(0)[1]
        substring= line [0, finish]
        substring.strip

        case match[0]
        when match[1]
          formated<< substring.sub(/\s+/, " ").lstrip

        when match[2]
          escaped_character= !((substring.count("\\"))% 2).zero? ? substring.sub(/\\+[ntr"]/, " ") : substring
          formated<< escaped_character

        when match[3]
          formated<< substring.sub(/\s+/, "")

        when match[4]
          formated<< substring.sub(/\./, ".\n")
        end

        line= match.post_match
      end
    end
  end
  File.open("./Files/formatted.txt", "w") {|f| f.write(formated)}
end

format_file()
