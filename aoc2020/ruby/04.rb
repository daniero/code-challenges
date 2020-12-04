passports = File
  .read('../input/04.txt')
  .split("\n\n")
  .map { |chunk| chunk.scan(/(\w+):(\S+)/).to_h }

# Part 1

part1 = passports.select { |passport|
  passport.size == 8 ||
  passport.size == 7 && !passport.has_key?('cid')
}

puts part1.length

# Part 2

pp part1.count { |passport|
  byr = passport['byr']&.to_i
  next false if !byr || byr < 1920 || byr > 2002

  iyr = passport['iyr']&.to_i
  next false if !iyr || iyr < 2010 || iyr > 2020

  eyr = passport['eyr']&.to_i
  next false if !eyr || eyr < 2020 || eyr > 2030

  next false unless passport['hgt']&.=~ /^(\d+)(cm|in)$/
  next false if $2 == 'cm' && ($1.to_i < 150 || $1.to_i > 193)
  next false if $2 == 'in' && ($1.to_i <  59 || $1.to_i >  76)

  next false unless passport['hcl']&.=~ /^#[0-9a-f]{6}$/
  next false unless passport['ecl']&.=~ /^(amb|blu|brn|gry|grn|hzl|oth)$/
  next false unless passport['pid']&.=~ /^\d{9}$/

  true
}

# 6 er feil
