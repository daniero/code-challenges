const { combinations } = require("../utils/generators");

function part1(numbers) {
  const iterable = combinations(numbers, 2);
  return iterable
    .find(([a, b]) => a + b === 2020)
    .reduce((a, b) => a * b, 1)
}

module.exports = { part1 };
