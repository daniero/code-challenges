const { readLines } = require('../utils/files');
const { Iterable } = require('../utils/Iterable');
const { parsePasswordPolicy, part1, part2  } = require("./solver");

const passwordPolicies =
  readLines('../input/02.txt')
    .map(parsePasswordPolicy);

const iterable = Iterable.of(passwordPolicies);

console.log(iterable.count(part1));
console.log(iterable.count(part2));

