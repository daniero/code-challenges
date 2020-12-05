const day = process.argv[2].padStart(2, '0');
const file = `./src/${day}/index.js`;

require(file);
