const { Iterable } = require("./Iterable");

module.exports = { combinations };

function combinations(elements, n) {
  if (n === 1) {
    return elements.map(element => [element]);
  }

  return new Iterable(function* () {
    const maxIndex = elements.length - n;

    for (let index = 0; index <= maxIndex; index++) {
      const element = elements[index];
      const otherCombinations = combinations(elements.slice(index + 1), n - 1);

      for (const combination of otherCombinations) {
        yield [element, ...combination];
      }
    }
  });
}

