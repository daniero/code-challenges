tally = File
  .read('../input/11-sample.txt')
  .scan(/\d+/).map(&:to_i)
  .tally

75.times do
  next_tally = Hash.new { 0 }

  tally.each do |i,n|
    case
    when i == 0 
      next_tally[1] += n
    when i.digits.length.even?
      d = i.to_s
      next_tally[d[0,d.size/2].to_i] += n
      next_tally[d[d.size/2..].to_i] += n
    else
      next_tally[i*2024] += n
    end
  end

  tally = next_tally
end

p tally.values.sum
