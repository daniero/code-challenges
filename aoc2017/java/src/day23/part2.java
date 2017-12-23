package day23;

class Part2 {
    static long part2() {
        final long C = 124900;

        long b = 107900;

        long d = 0;
        long e = 0;
        long f = 0;
        long g = 0;
        long h = 0;

        int GOTO = 8;

        while (true) {
            switch (GOTO) {
                // @formatter:off
                case 8:
                System.out.printf("b=%d, d=%d, e=%d, f=%d, g=%d, h=%d\n", b, d, e, 1, g, h);
                    f = 1;
                    d = 2;

                case 10:
                    e = 2;

                case 11:
                    g = d*e - b;
                    if (g == 0) { f = 0; }

                    e++;
                    g = e - b;
                    if (g != 0) { GOTO = 11; break; }

                    d++;
                    g = d - b;
                    if (g != 0) { GOTO = 10; break; }

                    if (f == 0) { h++; }

                    g = b - C;
                    if (g == 0) { return h; }

                    b+= 17;
                    GOTO = 8;
                // @formatter:on
            }
        }
    }
}

// Is it lcm?
// Nope: 107900.lcm(124900) => 134767100 => too high
// Is it gcd?
// Nope: 124900.gcd 107900 => 100 => too low
