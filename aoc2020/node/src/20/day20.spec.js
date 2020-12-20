const { Tile } = require('./Tile');

describe('Tile', () => {
  it('has correct edges', () => {
    const tile = new Tile(123, [
      "..##.#..#.",
      "##..#.....",
      "#...##..#.",
      "####.#...#",
      "##.##.###.",
      "##...#.###",
      ".#.#.#..##",
      "..#....#..",
      "###...#.#.",
      "..###..###",
    ]);

    expect(tile.upperEdge()).toEqual("..##.#..#.");
    expect(tile.lowerEdge()).toEqual("..###..###");
    expect(tile.leftEdge()).toEqual(".#####..#.");
    expect(tile.rightEdge()).toEqual("...#.##..#");
  });

  it('gives 8 unique rotations', () => {
    const tile = new Tile(123, [
      "..##.#..#.",
      "##..#.....",
      "#...##..#.",
      "####.#...#",
      "##.##.###.",
      "##...#.###",
      ".#.#.#..##",
      "..#....#..",
      "###...#.#.",
      "..###..###",
    ]);

    const rotations = new Set();
    for (const rotation of tile.rotations()) {
      expect(rotations).not.toContain(rotation);
      rotations.add(rotation);
    }
  });

  it('rotates correctly', () => {
    const rotations = new Tile(123, [
      "AB",
      "DC"
    ]).rotations();

    // Initial
    expect(rotations.next().value.data).toEqual([
      "AB",
      "DC"
    ]);
    // Rotate clockwise
    expect(rotations.next().value.data).toEqual([
      "DA",
      "CB"
    ]);
    // Rotate clockwise
    expect(rotations.next().value.data).toEqual([
      "CD",
      "BA"
    ]);
    // Rotate clockwise
    expect(rotations.next().value.data).toEqual([
      "BC",
      "AD"
    ]);
    // flip
    expect(rotations.next().value.data).toEqual([
      "CB",
      "DA"
    ]);
    // Rotate clockwise
    expect(rotations.next().value.data).toEqual([
      "DC",
      "AB"
    ]);
    // Rotate clockwise
    expect(rotations.next().value.data).toEqual([
      "AD",
      "BC"
    ]);
    // Rotate clockwise
    expect(rotations.next().value.data).toEqual([
      "BA",
      "CD"
    ]);
    // Done
    expect(rotations.next().done).toBe(true);
  });
});