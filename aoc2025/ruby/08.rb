sample = false

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

by_distance = input.combination(2).sort_by { |a,b|
  Math.sqrt(a.zip(b).sum { |ai,bi| (ai-bi)**2 })
}

circuits = input.to_h { [it,Set[it]] }

by_distance.take(N).each do |a,b|
  cb = circuits[b]
  merged = circuits[a].merge(cb)

  cb.each { |x| circuits[x] = merged }
end

p circuits.values.uniq.map(&:size).max(3).reduce(:*)
