p File
  .open("../input/05.txt")
  .each_line
  .count { |line| line =~ /(..).*\1/ && line =~ /(.).\1/ }

