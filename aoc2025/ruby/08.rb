sample = true

if sample
  input_file = '../input-sample08.txt'
  N = 10
else
  input_file = '../input-real08.txt'
  N = 1000
end


input = File
  .readlines(input_file)
  .map { it.scan(/\d+/).map(&:to_i) }

circuits = input.to_h { [it,Set[it]] }
by_distance = input.combination(2).sort_by { |a,b|
  Math.sqrt(a.zip(b).sum { |ai,bi| (ai-bi)**2 })
}

print "Part 1: "
by_distance.take(N).each do |a,b|
  ca,cb = circuits.values_at a, b
  next if ca == cb

  ca.merge cb
  cb.each { circuits[it] = ca }
end

puts circuits.values.uniq.map(&:size).max(3).reduce(:*)

print "Part 2: "
by_distance.drop(N).each do |a,b|
  ca,cb = circuits.values_at a, b
  next if ca == cb

  ca.merge cb
  cb.each { circuits[it] = ca }

  if circuits.values.uniq.size == 1
    puts a[0]*b[0]
    break
  end
end

