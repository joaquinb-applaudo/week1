def format_file ()
  matches= []
  File.open ("strings.txt") do |file|
    regex=  Regexp.new(/(\w+)|(\\+?[nrt"\'])|([\.:,;|])/)

    while line= file.gets
      line= line.dump
      while match= regex.match(line)
          word= [match[1], 1]
          escaped_symbols= [match[2], 1]
          punctutation= [match[3], 0]

          matches << word if word[0]

          matches << escaped_symbols if escaped_symbols[0] &&
                                        (escaped_symbols[0].length-1)%4==0

          matches << punctutation if punctutation[0]
          line= match.post_match
      end
    end
  end

  formated=""
  prev_match= nil;
  matches.each do |match|
    formated<< " " if prev_match==1 && match[1]!=0

    if match[1]==0
      formated <<(match[0]== "." ? ".\n" : "#{match[0]} ")
    else formated<< match[0] end

    prev_match= match[1]
  end
  File.open("formatted.txt", "w") {|f| f.write(formated)}
end

format_file()
