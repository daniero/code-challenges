class Iterable {
  constructor(generator) {
    this[Symbol.iterator] = generator;
  }
}

module.exports = { Iterable };

Iterable.prototype.find = function (predicate) {
  let iterable = this;
  for (let value of iterable) {
    if (predicate(value))
      return value;
  }
};

