const { readLines } = require('../utils/files');

const input = readLines('../input/24.txt');
// const input = readLines('../input/24-test.txt');

const axes = {
  e: [+1, 0],
  se: [0, +1],
  sw: [-1, +1],
  w: [-1, 0],
  nw: [0, -1],
  ne: [+1, -1]
};

// Part 1

const flip = (arr, x, y) => {
  if (!arr[x]) arr[x] = {};
  arr[x][y] = !arr[x][y];
}

const grid = {};
input.forEach(line => {
  const coord = line.match(/[ns]?[ew]/g).map(dir => axes[dir]).reduce(([i, j], [x, y]) => [i + x, j + y], [0, 0]);
  flip(grid, ...coord);
});

console.log(Object.values(grid).reduce((sum, col) => sum + Object.values(col).filter(x => x).length, 0))

// Part 2

const get = (arr, x, y) => arr[x] && arr[x][y]

const set = (arr, x, y, value) => {
  if (!arr[x]) arr[x] = {};
  arr[x][y] = value;
}

const neighbours = (grid, x, y) => Object.values(axes).map(([i, j]) => [x + i, j + y]);

let state = grid;
for (let i = 0; i < 100; i++) {
  let minX = Infinity, maxX = -Infinity, minY = Infinity, maxY = -Infinity;
  Object.entries(state).forEach(([x, col]) => Object.entries(col).forEach(([y, value]) => {
    minX = Math.min(minX, x);
    maxX = Math.max(maxX, x);
    minY = Math.min(minY, y);
    maxY = Math.max(maxY, y);
  }));

  const nextState = {};

  for (let x = minX - 1; x <= maxX + 1; x++) {
    for (let y = minY - 1; y <= maxY + 1; y++) {
      const cell = get(state, x, y);
      const liveNeighbours = neighbours(state, x, y).reduce((sum, [i, j]) => {
        return get(state, i, j) ? sum + 1 : sum;
      }, 0);
      if (cell && (liveNeighbours === 0 || liveNeighbours > 2)) {
        set(nextState, x, y, false);
      } else if (!cell && liveNeighbours === 2) {
        set(nextState, x, y, true);
      } else {
        set(nextState, x, y, get(state, x, y));
      }
    }
  }

  state = nextState;
}

console.log(Object.values(state).reduce((sum, col) => sum + Object.values(col).filter(x => x).length, 0));
