if false
  WIDTH = 11
  HEIGHT = 7
  INPUT = '../input/14-sample.txt'
else
  WIDTH = 101
  HEIGHT = 103
  INPUT = '../input/14.txt'
end

TIME = 100


input = File
  .readlines(INPUT)
  .map { _1.scan(/-?\d+/).map(&:to_i).each_slice(2).to_a }


# Part 1
input
  .map { |(x,y),(vx,vy)| [(x+vx*TIME)%WIDTH, (y+vy*TIME)%HEIGHT] }
  .filter { |x,y| x != WIDTH/2 && y != HEIGHT/2 }
  .group_by { |x,y| [x < (WIDTH/2), y < (HEIGHT/2)] }
  .values.map(&:size)
  .reduce(:*)
  .then { puts _1 }


# Part 2
max = 0

5000.times do |i|
  map = input.map { |(x,y),(vx,vy)| [(x+vx*i)%WIDTH, (y+vy*i)%HEIGHT] }.tally
  neigbours = map.keys.combination(2).count { |(x1,y1),(x2,y2)| ((x1-x2).abs <= 1 && (y1-y2).abs <= 1) }

  if (neigbours > max)
    puts "==== #{i} ============"
    HEIGHT.times do |y|
      puts WIDTH.times.map { |x| map[[x,y]] || ' ' }.join
    end
    puts

    max = neigbours
  end
end
