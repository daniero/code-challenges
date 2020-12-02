input = File
  .readlines('../input/02.txt')
  .map { |line|
    line =~ /(\d+)-(\d+) (\w): (\w+)/
    [$1.to_i, $2.to_i, $3, $4]
  }

p input.count { |min,max,char,password|
  n = password.count(char)
  min <= n && n <= max
}
