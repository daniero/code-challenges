*a,b = File
  .read('../input-real12.txt')
  .split("\n\n")

$presents = a.map { it.lines.drop(1).map { it.chomp.chars } }

def fit(w,h, *ns)
  area = w*h
  presents_exact_area = ns.each_with_index.sum { |n,i|
    n * $presents[i].join.count('#')
  }
  return false if area < presents_exact_area

  min_presents_possible = (w/3) * (h/3)
  total_presents = ns.sum
  return true if min_presents_possible >= total_presents

  # We don't seem to need to check for optimized packing ¯\_(ツ)_/¯
  throw "now what?"
end

pp b
  .lines
  .map { it.scan(/\d+/).map(&:to_i) }
  .count { |w,h,*ns|
    fit(w,h,*ns)
  }
