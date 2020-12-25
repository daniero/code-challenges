const INPUT = 496138527;

function solve(start, max, nextNumbers, moves) {
  let current = start
  let pickedUp1;
  let pickedUp2;
  let pickedUp3;
  let destination;

  function pickUp() {
    pickedUp1 = nextNumbers[current];
    pickedUp2 = nextNumbers[pickedUp1];
    pickedUp3 = nextNumbers[pickedUp2];
    nextNumbers[current] = nextNumbers[pickedUp3];
  }

  function findDestination() {
    destination = current;
    do {
      destination--;
      if (destination === 0) destination = max;
    } while (destination === pickedUp1 || destination === pickedUp2 || destination === pickedUp3);
  }

  function placeBackDown() {
    const oldNext = nextNumbers[destination];
    nextNumbers[destination] = pickedUp1;
    nextNumbers[pickedUp3] = oldNext;
  }

  function rotate() {
    current = nextNumbers[current];
  }

  for (let i = 1; i <= moves; i++) {
    pickUp();
    findDestination();
    placeBackDown()
    rotate()
  }
  return current;
}

// Part 1

function findAnswerPart1(nextNumbers) {
  const answer = [];
  let next = 1;
  for (let i = 0; i < 8; i++) {
    next = nextNumbers[next];
    answer.push(next);
  }
  return answer;
}

const numbers = [...INPUT.toString()].map(c => parseInt(c));
const firstNumber = numbers[0];

const nextNumbers = new Array(numbers.length + 1);
numbers.forEach((number, i) => {
  nextNumbers[number] = numbers[(i + 1) % numbers.length];
});

solve(firstNumber, Math.max(...numbers), nextNumbers, 100);
console.log(`Part 1: ${findAnswerPart1(nextNumbers).join('')}`)

// Part 2

const oneMillion = 1000000;
const tenMillion = 10000000;

const nextNumbers2 = new Array(oneMillion + 1);
nextNumbers2[0] = null;
numbers.forEach((number, i) => {
  nextNumbers2[number] = numbers[(i + 1) % numbers.length];
});
const firstFillerNumber = Math.max(...numbers) + 1;
for (let i = firstFillerNumber; i < oneMillion; i++) {
  nextNumbers2[i] = i + 1
}
nextNumbers2[numbers[numbers.length - 1]] = firstFillerNumber;
nextNumbers2[oneMillion] = firstNumber;

solve(firstNumber, oneMillion, nextNumbers2, tenMillion);
const part2 = nextNumbers2[1] * nextNumbers2[nextNumbers2[1]];
console.log(`Part 2: ${part2}`)
