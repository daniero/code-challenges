package day23;

class Part2 {
    static long part2() {
        long b = 107900;
        long c = 124900;

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
                    f = 1;
                    d = 2;

                case 10:
                    e = 2;

                case 11:
                    g = d;
                    g*= e;
                    g-= b;
                    if (g != 0) { GOTO = 16; break; }
                    f = 0;

                case 16:
                    e++;
                    g = e;
                    g-= b;
                    if (g != 0) { GOTO = 11; break; }
                    d++;
                    g = d;
                    g-= b;
                    if (g != 0) { GOTO = 10; break; }
                    if (f == 0) { h++; }

                    g = b;
                    g-= c;

                    if (g != 0) { GOTO = 30; break; }
                    return h;

                case 30:
                    b+= 17;
                    GOTO = 8; break;

                // @formatter:on
            }
        }
    }
}

// Is it lcm?
// Nope: 107900.lcm(124900) => 134767100 => too high
// Is it gcd?
// Nope: 124900.gcd 107900 => 100 => too low
