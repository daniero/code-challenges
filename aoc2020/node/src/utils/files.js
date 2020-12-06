const fs = require('fs');

const readLines = (filename) => {
  const input = fs.readFileSync(filename, 'utf8');
  return input.trimEnd().split("\n");
};

module.exports = { readLines };
