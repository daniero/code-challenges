r, m = File
  .read('../input/19.txt')
  .split("\n\n")
  .map { |chunk| chunk.lines.map(&:chomp) }

rules =
  r.map { |line|
    line
      .gsub(': ', '=>[[').then { _1 + ']]' }
      .gsub(' | ', '],[')
      .gsub(' ', ',')
  }
  .join(",\n")
  .then { ?{ + _1 + ?} }
  .then { eval _1 }

resolve = Hash.new do |h,k|
  rule = rules[k].map { |subrule|
    subrule.map { |subsubrule|
      String === subsubrule ? subsubrule : h[subsubrule]
    }.join
  }.then { |res| res.length == 1 ? res.first : "(#{res.join('|')})" }

  h[k] = rule
end

accept = Regexp.new(?^+resolve[0]+?$)

p m.grep(accept).count
