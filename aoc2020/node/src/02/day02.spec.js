const { parsePasswordPolicy, part1, part2  } = require("./solver");

describe('Day 2', () => {
  describe('part 1', function () {
    describe.each([
      ['1-3 a: abcde', true],
      ['1-3 b: cdefg', false],
      ['2-9 c: ccccccccc', true]
    ])('Given "%s"', (input, expected) => {
      it(`it returns ${expected}`, () => {
        const result = part1(parsePasswordPolicy(input));

        expect(result).toBe(expected);
      });
    });
  });

  describe('part 2', function () {
    describe.each([
      ['1-3 a: abcde', true],
      ['1-3 b: cdefg', false],
      ['2-9 c: ccccccccc', false]
    ])('Given "%s"', (input, expected) => {
      it(`it returns ${expected}`, () => {
        const result = part2(parsePasswordPolicy(input));

        expect(result).toBe(expected);
      });
    });
  });
});