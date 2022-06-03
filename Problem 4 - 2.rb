def counter (regex, file)
  matches= 0
  File.open (file) do |file|
    while line= file.gets
      while match= regex.match(line.downcase)
        matches+=1;
        line= match.post_match
      end
    end
  end
  return matches;
end


def check_ocurrences
  regex_dis= Regexp.new(/^dis/)
  regex_ing= Regexp.new(/ing.?$/)
  directory=  "./Files"

  dis_f1= counter(regex_dis, "#{directory}/strings.txt")
  dis_f2= counter(regex_dis, "#{directory}/formatted.txt")
  ing_f1= counter(regex_ing, "#{directory}/strings.txt")
  ing_f2= counter(regex_ing, "#{directory}/formatted.txt")

  puts "Unordered Document:", "dis: #{dis_f1}", "ing: #{ing_f1}"
  puts "Formatted:", "dis: #{dis_f2}", "ing: #{ing_f2}"

end

check_ocurrences
