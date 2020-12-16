const startingNumbers = [14, 3, 1, 0, 9, 5]
const N = 30_000_000;

const spoken = startingNumbers.reduce((acc, n, i) => ({
  ...acc,
  [n]: i + 1
}), {});

let prev = startingNumbers[startingNumbers.length - 1];
let next = null;

for (let turn = startingNumbers.length + 1; turn <= N; turn++) {
  const previouslySpokenTurn = spoken[prev];

  if (previouslySpokenTurn !== undefined) {
    next = turn - 1 - previouslySpokenTurn;
  } else {
    next = 0;
  }

  spoken[prev] = turn - 1;
  prev = next
}

console.log(next);
