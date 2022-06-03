#////////////////////////////////////////////////////////

def mean (arr)
  return arr.reduce(:+)/arr.length
end

puts mean [6, 3, 100,3 ,13]

#////////////////////////////////////////////////////////

even_median= lambda {|arr, med| arr[med, 2].reduce(:+)/2}

def median (arr, ev_med)
  sorted= arr.sort
  size= arr.length
  med_i= (size/2.0)-1

  return ev_med.call(sorted, med_i) if size.even?

  return sorted[med_i.ceil]
end

p median [18, 10, 13, 10, 17, 11, 9], even_median

#////////////////////////////////////////////////////////

def mode (arr)
  frequency_map= Hash.new(0)
  arr.each {|element| frequency_map[element]+=1}
  mode= frequency_map.sort_by {|num, count| count }.last
  return mode.first
end

p mode [9,8,7,1,1, 2 , 2, 5 ]

#////////////////////////////////////////////////////////


