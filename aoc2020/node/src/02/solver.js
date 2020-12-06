module.exports = { parsePasswordPolicy, part1, part2 };

const { Iterable } = require('../utils/Iterable');

function parsePasswordPolicy(line) {
  const [_, min, max, char, password] = line.match(/(\d+)-(\d+) (\w): (\w+)/);
  return {
    min: parseInt(min),
    max: parseInt(max),
    char,
    password
  };
}

function part1({ min, max, char, password }) {
  const n = Iterable.of(password).count(c => c === char);

  return min <= n && n <= max;
}

function part2({ min, max, char, password }) {
  return !!((password[min - 1] === char) ^ (password[max - 1] === char))
}

