class Tile {
  constructor(id, data) {
    this.id = id;
    this.data = data;
    this.rot = [];
  }

  upperEdge() {
    return this.data[0];
  }

  lowerEdge() {
    return this.data[this.data.length - 1];
  }

  leftEdge() {
    return this.lE || (this.lE = this.data.map(row => row[0]).join(''));
  }

  rightEdge() {
    return this.rE || (this.rE = this.data.map(row => row[row.length - 1]).join(''));
  }

  * rotations() {
    yield this;
    let data = this.data;

    for (let i = 1; i < 8; i++) {
      if (this.rot[i]) {
        yield this.rot[i];
        continue;
      }
      if (i === 4) {
        data = flip(data);
      } else {
        data = rotate(data);
      }

      yield this.rot[i] = new Tile(this.id, data);
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


module.exports = { Tile };