const input = 496138527;
const moves = 100;
// test:
// const input = 389125467;
// const moves = 10;

const cups = [...input.toString()]
  .map(c => parseInt(c))
  .map(n => ({ label: n }));

cups.forEach((cup, i) => {
  cup.next = cups[(i + 1) % cups.length];
});

const print = (first) => {
  let next = first;
  const labels = [];
  do {
    labels.push(next.label);
    next = next.next;
  } while (next && next !== first);
  if (next) {
    labels.push('...');
  }
  return labels.join(', ');
}

let current = cups[0]
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
  pickUp();
  findDestination();
  placeBackDown()
  rotate()
}

console.log("final:")
console.log(`Cups: ${print(current)}`)
