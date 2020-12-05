const file = `./src/${process.argv[2].padStart(2, '0')}.js`;

require(file);
