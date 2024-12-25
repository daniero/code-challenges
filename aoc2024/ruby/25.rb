locks, keys = File
  .read('../input/25-sample.txt')
  .split("\n\n")
  .map(&:split)
  .partition { _1[0][0] == '#' }

p locks.product(keys).count { |lock,key|
  lock.zip(key).all? { |lock_row, key_row|
    lock_row.chars.zip(key_row.chars).all? { |l,k| l == '.' || k == '.' }
  }
}
