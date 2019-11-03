INSTRUCTIONS = {
  addr: ->(a,b,c, regs) { regs[c] = regs[a] + regs[b] },
  addi: ->(a,b,c, regs) { regs[c] = regs[a] + b },
  mulr: ->(a,b,c, regs) { regs[c] = regs[a] * regs[b] },
  muli: ->(a,b,c, regs) { regs[c] = regs[a] * b },
  banr: ->(a,b,c, regs) { regs[c] = regs[a] & regs[b] },
  bani: ->(a,b,c, regs) { regs[c] = regs[a] & b },
  borr: ->(a,b,c, regs) { regs[c] = regs[a] | regs[b] },
  bori: ->(a,b,c, regs) { regs[c] = regs[a] | b },
  setr: ->(a,_,c, regs) { regs[c] = regs[a] },
  seti: ->(a,_,c, regs) { regs[c] = a },
  gtir: ->(a,b,c, regs) { regs[c] = a > regs[b] ? 1 : 0 },
  gtri: ->(a,b,c, regs) { regs[c] = regs[a] > b ? 1 : 0 },
  gtrr: ->(a,b,c, regs) { regs[c] = regs[a] > regs[b] ? 1 : 0 },
  eqir: ->(a,b,c, regs) { regs[c] = a == regs[b] ? 1 : 0 },
  eqri: ->(a,b,c, regs) { regs[c] = regs[a] == b ? 1 : 0 },
  eqrr: ->(a,b,c, regs) { regs[c] = regs[a] == regs[b] ? 1 : 0 },
}

