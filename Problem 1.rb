#The two params in the method are used like so:
  #series: Will determine how many iterations will be made.
  #----------------------------------------------------------------------------------------------------
  #str_len: Determines the base length for the strings.
  #Its default value is <1>. Simply put, if you run the method with series=1 and str_len=2
  #the return value will be an array containing: [aa, ab, ac, ..., zz].
  #Whilst using series=2 and the default str_len value will return [a, b, c ..., aa, ab, ac, ..., zz]

def alphabetic_iteration (series, str_len=1)
  if (!(Integer===series && Integer=== str_len))
    return nil;

  a= "a"*str_len
  z= "z"*str_len
  combinations= []

  1.upto(series).each do
    (a..z).to_a.each {|element| combinations<< element}
    a+= a;
    z+= z;
  end
  return combinations
end

puts alphabetic_iteration(2).join(" ")

#Using a different argument str_len:
#puts alphabetic_iteration(1, 3).join (" ")
