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

p input.count { |min,max,char,password|
  a,b = password
    .chars.values_at(min-1,max-1)
    .map { |c| c == char }

  a ^ b
}

