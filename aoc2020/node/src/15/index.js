let startingNumbers = [14, 3, 1, 0, 9, 5]

const ns = [...startingNumbers];

const speak = () => {
  const prev = ns[ns.length - 1];

  const previouslySpoken = ns.lastIndexOf(prev, ns.length - 2);
  if (previouslySpoken !== -1) {
    const next = ns.length - 1 - previouslySpoken;
    ns.push(next);
    return next;
  } else {
    const next = 0;
    ns.push(next);
    return next;
  }
}

const times = 2020 - ns.length;
for (let i = 0; i < times; i++) {
  speak();
}

console.log(ns[ns.length - 1]);
