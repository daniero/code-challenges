const { flip, rotate } = require('./Tile');

module.exports = { stitchImages: stitchImage, scanForSeaMonsters };

const monster = [
  "                  # ",
  "#    ##    ##    ###",
  " #  #  #  #  #  #   "
];

function scanForSeaMonsters(data) {
  const monsterCoords = findHashes(monster);

  let image = stitchImage(data);
  let monstersFound, i = 0;

  do {
    if (i === 4) {
      image = flip(image);
    } else if (i > 0) {
      image = rotate(image);
    }

    monstersFound = scan(image, monsterCoords);
  } while (monstersFound.length === 0 && i++ < 8);

  return image.join('').replace(/[^#]/g, '').length - monstersFound.length * monsterCoords.length;
}

function scan(image, monsterCoords) {
  const monstersFound = [];

  for (let y = 0; y < image.length - monster.length; y++) {
    for (let x = 0; x < image[0].length - monster[0].length; x++) {
      if (monsterCoords.every(([mX, mY]) => image[y + mY][x + mX] === '#')) {
        monstersFound.push([x, y]);
        image[y][x] = 'A';
      }
    }
  }
  return monstersFound;
}

// 2501 too high

function stitchImage(data) {
  const imageRows = [];

  data
    .map(tilesRow => tilesRow
      .map(tile => tile
        .data
        .slice(1, -1)
        .map(pixelRow => [...pixelRow].slice(1, -1).join(''))
      ))
    .forEach(dataRow => {
      for (let y = 0; y < dataRow[0].length; y++) {
        imageRows.push(dataRow.map(data => data[y]).join(''));
      }
    });

  return imageRows;
}

function findHashes(strings) {
  const coords = [];
  strings.forEach((line, y) => {
    for (let x = 0; x < line.length; x++) {
      if (line[x] === '#') {
        coords.push([x, y]);
      }
    }
  });
  return coords;
}
