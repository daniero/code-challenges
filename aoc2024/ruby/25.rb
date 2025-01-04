locks, keys = File
  .read('../input/25-sample.txt')
  .split("\n\n")
  .map { _1.split.map(&:chars) }
  .partition { _1[0][0] == '#' }

p locks.product(keys).count { |lock,key|
  lock.zip(key).all? { |lock_row, key_row|
    lock_row.zip(key_row).all? { _1.include? '.' }
  }
}
