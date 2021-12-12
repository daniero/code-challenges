def path(vx, vy)
  x,y = 0,0

  loop do
    x += vx
    y += vy
    yield x,y
    vx -= 1 if vx > 0
    vy -= 1
  end
end

def inside?(target, coord)
  tx1, tx2, ty1, ty2 = target
  x,y = coord

  x.between?(*[tx1, tx2].minmax) && y.between?(*[ty1, ty2].minmax)
end


def past?(target, coord)
  (tx1, tx2, ty1, ty2) = target
  (x,y) = coord

  x > [tx1,tx2].max || y < [ty1,ty2].min
end

def height(target, vx, vy)
  max = 0
  path(vx, vy) { |x,y|
    max = y if y > max
    return max if inside?(target, [x,y])
    return nil if past?(target, [x,y])
  }
end


input = "target area: x=265..287, y=-103..-58"
tx1, tx2, ty1, ty2 = target = input.scan(/-?\d+/).map(&:to_i)

hits = 0
max_height = 0

(0..300).each { |vx|
  (-200..1000).each { |vy|
    h = height(target, vx, vy)
    hits += 1 if h
    max_height = h if h && h > max_height
  }
}

p max_height
p hits
