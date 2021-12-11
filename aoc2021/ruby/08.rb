input = File
  .readlines(ARGV[0] || '../input/08.txt')
  .map { |line|
    line.split('|').map { |section|
      section.scan(/\w+/)
    }
  }


# Part 1

p input.sum { |_, output| output.count { |value| [2,4,3,7].include?(value.length) } }


# Part 2

DISPLAY_DIGITS = {
  0 => 'abcefg',
  1 => 'cf',
  2 => 'acdeg',
  3 => 'acdfg',
  4 => 'bcdf',
  5 => 'abdfg',
  6 => 'abdefg',
  7 => 'acf',
  8 => 'abcdefg',
  9 => 'abcdfg',
}

p input.sum { |signals, output|
  permutation = 'abcdefg'.chars.permutation.lazy.map(&:join).find { |perm|
    signals
      .map { _1.tr('abcdefg', perm) }
      .map { _1.chars.sort.join }
      .all? { DISPLAY_DIGITS.has_value?(_1) }
  }

  output
    .map { _1.tr('abcdefg', permutation).chars.sort.join }
    .map { DISPLAY_DIGITS.key _1 }
    .join
    .to_i
}
