function solve(start, moves) {
  let current = start
  let pickedUp;
  let destination;

  function pickUp() {
    const first = current.next;
    const last = first.next.next;
    current.next = last.next;
    last.next = null;
    pickedUp = first;
  }

  function findDestination() {
    const pickedUpLabels = [pickedUp.label, pickedUp.next.label, pickedUp.next.next.label];
    destination = current.label;
    do {
      destination--;
      if (destination === 0) destination = 9;
    } while (pickedUpLabels.includes(destination));
  }

  function placeBackDown() {
    let next = current.next;
    while (next.label !== destination) {
      next = next.next;
    }
    const oldNext = next.next;
    next.next = pickedUp;
    pickedUp.next.next.next = oldNext;
  }

  function rotate() {
    current = current.next;
  }

  for (let i = 1; i <= moves; i++) {
    if (i % 100000 === 0) process.stdout.write(".");
    pickUp();
    findDestination();
    placeBackDown()
    rotate()
  }
  return current;
}

function rotateToCup1(cup) {
  let current = cup;
  while (current.label !== 1) current = current.next;
  return current;
}

const print = (first) => {
  let next = first;
  const labels = [];
  do {
    labels.push(next.label);
    next = next.next;
  } while (next && next !== first);
  return labels.slice(1).join('');
}

// const input = 389125467; //test
const input = 496138527;

// Part 1

const cups1 = [...input.toString()]
  .map(c => parseInt(c))
  .map(n => ({ label: n }));

cups1.forEach((cup, i) => {
  cup.next = cups1[(i + 1) % cups1.length];
});

const part1 = solve(cups1[0], 100);

console.log("Part 1:")
console.log()
console.log(`Cups: ${print(rotateToCup1(part1))}`)

// Part 2

const cups2 = [...input.toString()]
  .map(c => parseInt(c))
  .map(n => ({ label: n }));

cups2.forEach((cup, i) => {
  cup.next = cups2[(i + 1) % cups2.length];
});

const first = cups2[0];
let next = cups2[cups2.length - 1];

const oneMillion = 1000000;
const hundredMillion = 100000000;

for (let i = 10; i <= oneMillion; i++) {
  next.next = { label: i };
  next = next.next
}

next.next = first

console.log("Part 2:")
const part2 = rotateToCup1(solve(first, hundredMillion));

console.log(part2.next * part2.next.next);
