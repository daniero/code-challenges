const { readLines } = require('../utils/files');
const { part1, part2 } = require("./solver");

const input =
  readLines('../input/01.txt')
    .map(line => parseInt(line));

console.log(part1(input));
console.log(part2(input));
