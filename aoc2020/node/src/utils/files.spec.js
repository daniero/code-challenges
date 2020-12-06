const fs = require('fs');
const { readLines } = require("./files");

describe('readLines', () => {
  beforeAll(() => jest.spyOn(fs, 'readFileSync'));
  afterAll(() => jest.resetAllMocks());

  it('handles one line', function () {
    fs.readFileSync.mockReturnValue("Hey!");

    expect(readLines()).toEqual(["Hey!"]);
  });

  it('handles trailing newline', function () {
    fs.readFileSync.mockReturnValue("Hey\nHo\nLet's go\n");

    expect(readLines()).toEqual(["Hey", "Ho", "Let's go"]);
  });

  it('handles no trailing newline', function () {
    fs.readFileSync.mockReturnValue("Hey you\nRhe Rock Steady Crew");

    expect(readLines()).toEqual(["Hey you", "Rhe Rock Steady Crew"]);
  });
});

module.exports = { readLines };
