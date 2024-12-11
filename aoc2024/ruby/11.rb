input = File.read('../input/11-sample.txt').scan(/\d+/).map(&:to_i)

25.times do
  input = input.flat_map { |i|
    next [1] if i == 0 

    d = i.to_s
    if d.size.even?
      next [d[0,d.size/2].to_i, d[d.size/2..].to_i]
    end

    [i*2024]
  }
end

p input.size
