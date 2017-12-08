registers = Hash.new { |h,k| h[k] = 0 }

File.read('../input08.txt')
    .gsub(/^\w+|(?<=if )\w+/) { "registers['#{$&}']" }
    .gsub(/inc/, '+=')
    .gsub(/dec/, '-=')
    .each_line { |line| eval(line) }

puts registers.values.max


