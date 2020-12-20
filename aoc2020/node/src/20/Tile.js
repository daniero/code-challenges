class Tile {
  constructor(id, data, rotation = 0) {
    this.id = id;
    this.data = data;
    this._rotations = [];
  }

  upperEdge() {
    return this.data[0];
  }

  lowerEdge() {
    return this.data[this.data.length - 1];
  }

  leftEdge() {
    return this._leftEdge || (this._leftEdge = this.data.map(row => row[0]).join(''));
  }

  rightEdge() {
    return this._rightEdge || (this._rightEdge = this.data.map(row => row[row.length - 1]).join(''));
  }

  * rotations() {
    yield this;
    let data = this.data;

    for (let rotation = 1; rotation < 8; rotation++) {
      if (this._rotations[rotation]) {
        yield this._rotations[rotation];
        continue;
      }
      if (rotation === 4) {
        data = flip(data);
      } else {
        data = rotate(data);
      }

      yield this._rotations[rotation] = new Tile(this.id, data, rotation);
    }
  }
}


function rotate(data) {
  const newRows = [];
  for (let col = 0; col < data.length; col++) {
    const newColumn = [];
    for (let row = data.length - 1; row >= 0; row--) {
      newColumn.push(data[row][col]);
    }
    newRows.push(newColumn.join(''));
  }
  return newRows;
}

function flip(data) {
  return data.map(row => [...row].reverse().join(''));
}


module.exports = { Tile, rotate, flip };