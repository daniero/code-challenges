class Iterable {
  constructor(generator) {
    this[Symbol.iterator] = generator;
  }
}

module.exports = { Iterable };

Iterable.of = function (elements) {
  return new Iterable(function* () {
    for (const element of elements) {
      yield element;
    }
  });
};

Iterable.prototype.count = function (predicate) {
  let iterable = this;
  let matches = 0;
  for (let value of iterable) {
    if (predicate(value))
      ++matches;
  }
  return matches;
};

Iterable.prototype.find = function (predicate) {
  let iterable = this;
  for (let value of iterable) {
    if (predicate(value))
      return value;
  }
};

