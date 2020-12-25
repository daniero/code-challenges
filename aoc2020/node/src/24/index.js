const { readLines } = require('../utils/files');

const input = readLines('../input/24.txt');

const c = {
  e: [+1, 0],
  se: [0, +1],
  sw: [-1, +1],
  w: [-1, 0],
  nw: [0, -1],
  ne: [+1, -1]
}

const tiles = input.reduce((tiles, line) => {
  const coord = line.match(/[ns]?[ew]/g).map(dir => c[dir]).reduce(([i, j], [x, y]) => [i + x, j + y], [0, 0]).join(',');
  tiles[coord] = !tiles[coord];
  return tiles;
}, {});

console.log(Object.values(tiles).filter(x => x).length)