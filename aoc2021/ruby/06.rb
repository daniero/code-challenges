input = File.read('../input/06.txt').scan(/\d/).map(&:to_i)
#input = [3,4,3,1,2]


# Part 1

def step(fish = [])
  fish.flat_map { |f| f == 0 ? [6, 8] : [f-1] }
end

fish = input
80.times { fish = step(fish) }
p fish.count


# Part 2

def fast_step(fishtally)
  {
    8 => fishtally[0],
    7 => fishtally[8],
    6 => fishtally[7] + fishtally[0],
    5 => fishtally[6],
    4 => fishtally[5],
    3 => fishtally[4],
    2 => fishtally[3],
    1 => fishtally[2],
    0 => fishtally[1],
  }
end

fishtally = input.tally
fishtally.default = 0

256.times { fishtally = fast_step(fishtally) }
p fishtally.values.sum
