const { part1, part2 } = require("./solver");

describe('Day 1', function () {
  const testdata = [
    1721,
    979,
    366,
    299,
    675,
    1456
  ];

  describe('part 1', function () {
    it('finds the correct combination', function () {
      const result = part1(testdata);

      expect(result).toBe(514579);
    });
  });

  describe('part 2', function () {
    it('finds the correct combination', function () {
      const result = part2(testdata);

      expect(result).toBe(241861950);
    });
  });
});