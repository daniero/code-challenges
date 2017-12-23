package day23;

class Part2 {
    static long part2() {
        final long C = 124900;

        long b = 107900;

        long d = 0;
        long e = 0;
        long f = 0;
        long h = 0;

        do {
            System.out.printf("b=%d, d=%d, e=%d, f=%d, h=%d\n", b, d, e, f, h);
            f = 1;
            d = 2;

            do {
                e = 2;

                do {
                    if (d*e == b) { f = 0; }

                    e++;
                } while (e != b);

                d++;
            } while (d != b);

            if (f == 0) { h++; }

            if (b == C) { return h; }

            b += 17;
        } while (true);
    }
}

// Is it lcm?
// Nope: 107900.lcm(124900) => 134767100 => too high
// Is it gcd?
// Nope: 124900.gcd 107900 => 100 => too low
