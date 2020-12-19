r, m = File
  .read(ARGV[0] || '../input/19.txt')
  .split("\n\n")
  .map { |chunk| chunk.lines.map(&:chomp) }

rules =
  r.map { |line|
    line
      .gsub(': ', '=>[[').then { _1 + ']]' }
      .gsub(' | ', '],[')
      .gsub(' ', ',')
  }
  .join(',')
  .then { ?{ + _1 + ?} }
  .then { eval _1 }

def create_solver(rules)
  Hash.new do |h,k|
    rule = rules[k].map { |subrule|
      subrule.map { |subsubrule|
        String === subsubrule ? subsubrule : h[subsubrule]
      }.join
    }.then { |res| res.length == 1 ? res.first : "(#{res.join('|')})" }

    h[k] = rule
  end
end

# Part 1
solver = create_solver(rules)
inital_rule = Regexp.new(?^+solver[0]+?$)

p m.grep(inital_rule).count

# Part 2
solver = create_solver(rules)
solver[8] = "(#{solver[42]})+"
solver[11] = "(?<r>#{solver[42]}\\g<r>?#{solver[31]})"
inital_rule = Regexp.new(?^+solver[0]+?$)

p m.grep(inital_rule).count
