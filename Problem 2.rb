def problem2 (arr)
  frequency_map= Hash.new(0)
  arr.each {|element| frequency_map[element]+=1}
  return frequency_map
end

p problem2([1, 3, 3 , 2, 2, 2])
