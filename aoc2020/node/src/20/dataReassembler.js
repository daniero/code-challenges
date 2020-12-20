module.exports = { reassemble };

function reassemble(tiles) {
  const size = Math.sqrt(tiles.length);
  const image = new Array(size).fill(null).map(() => new Array(size));

  go(new Set(tiles), image, 0);

  return {
    checksum: checksum(image, size),
    data: image
  };
}

function go(tilesLeft, image, i) {
  const x = i % image.length;
  const y = Math.trunc(i / image.length);

  for (const tile of tilesLeft) {
    const tilesLeftNext = new Set([...tilesLeft]);
    tilesLeftNext.delete(tile);

    for (const rotation of tile.rotations()) {
      if (tileFits(rotation, image, x, y)) {
        image[y][x] = rotation;

        if (tilesLeftNext.size === 0) {
          return true;
        }

        const ok = go(tilesLeftNext, image, i + 1);
        if (ok) {
          return true;
        }

        image[y][x] = null;
      }
    }
  }
}

function tileFits(tile, image, x, y) {
  return (
    (x === 0 || image[y][x - 1].rightEdge() === tile.leftEdge()) &&
    (y === 0 || image[y - 1][x].lowerEdge() === tile.upperEdge())
  );
}

function checksum(image, size) {
  const corners = [
    image[0][0].id,
    image[0][size - 1].id,
    image[size - 1][0].id,
    image[size - 1][size - 1].id,
  ]

  return corners.reduce((acc, id) => acc * id, 1);
}
