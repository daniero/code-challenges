const fs = require('fs');
const { Tile } = require('./Tile');
const { reassemble } = require('./dataReassembler');

let input;
input = fs.readFileSync('../input/20.txt', 'utf8');
// input = fs.readFileSync('../input/20-test.txt', 'utf8');

const data = input
  .split('\n\n')
  .filter(x => x)
  .map(chunk => {
    const lines = chunk.split("\n");
    return new Tile(
      parseInt(lines[0].match(/\d+/)[0]),
      lines.slice(1)
    );
  });

const reassembledDataChecksum = reassemble(data);

console.log(reassembledDataChecksum);