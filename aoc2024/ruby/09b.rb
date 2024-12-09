input = File.read('../input/09.txt').chomp.chars.map(&:to_i)

Chunk = Struct.new(:data, :free)
Fyle = Struct.new(:id, :size)

def read_data(input)
  input.each_slice(2).map.with_index { |(used,free),i|
    Chunk.new(
      data: [Fyle.new(id: i, size: used)],
      free: free||0
    )
  }
end

def flatten(data)
  data.flat_map { |c| c.data.flat_map { |f| [f.id]*f.size } + ['.']*c.free }
end

def show(data)
  puts flatten(data).join
end

def hash(data)
  puts flatten(data).each_with_index.sum { |n,i| n == '.' ? 0 : n*i  }
end

def defrag!(data)
  data.each_with_index.reverse_each do |chunk,i|
    file = chunk.data.first
    free = data.take(i).find { _1.free >= file.size }

    if free
      free.data.push file.dup
      free.free-= file.size
      file.id = '.'
    end
  end
end

data = read_data(input)
defrag! data
#show data
hash data
