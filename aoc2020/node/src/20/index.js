const fs = require('fs');
const { Tile } = require('./Tile');
const { reassemble } = require('./dataReassembler');
const { scanForSeaMonsters } = require('./imageProcessor');

const input = fs.readFileSync('../input/20.txt', 'utf8');

const rawData = input
  .split('\n\n')
  .filter(x => x)
  .map(chunk => {
    const lines = chunk.split("\n");
    return new Tile(
      parseInt(lines[0].match(/\d+/)[0]),
      lines.slice(1)
    );
  });

// Part 1
const { checksum, data } = reassemble(rawData);
console.log(checksum);

// Part 2
console.log(scanForSeaMonsters(data));
