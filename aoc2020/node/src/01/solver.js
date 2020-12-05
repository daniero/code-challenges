const { combinations } = require("../utils/generators");

function part1(numbers) {
  return combinations(numbers, 2)
    .find(([a, b]) => a + b === 2020)
    .reduce((a, b) => a * b, 1)
}

function part2(numbers) {
  return combinations(numbers, 3)
    .find(([a, b, c]) => a + b + c === 2020)
    .reduce((a, b) => a * b, 1)
}

module.exports = { part1, part2 };
