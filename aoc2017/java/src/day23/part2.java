package day23;

class Part2 {
    static long part2() {
        long b;
        long c;

        b = 79;
        b *= 100;
        b-= -100000;
        c = b;
        c-= -17000;

        long d = 0;
        long e = 0;
        long f = 0;
        long g = 0;
        long h = 0;

        int GOTO = 8;

        while (true) {
            switch (GOTO) {
                // @formatter:off
                case 8: f = 1; GOTO++;
                case 9: d = 2; GOTO++;
                case 10: e = 2; GOTO++;
                case 11: g = d; GOTO++;
                case 12: g*= e; GOTO++;
                case 13: g-= b; GOTO++;
                case 14: if (g != 0) { GOTO = 16; break; }; GOTO++;
                case 15: f = 0; GOTO++;
                case 16: e-= -1; GOTO++;
                case 17: g = e; GOTO++;
                case 18: g-= b; GOTO++;
                case 19: if (g != 0) { GOTO = 11; break; }; GOTO++;
                case 20: d-= -1; GOTO++;
                case 21: g = d; GOTO++;
                case 22: g-= b; GOTO++;
                case 23: if (g != 0) { GOTO = 10; break; }; GOTO++;
                case 24: if (f != 0) { GOTO = 26; break; }; GOTO++;
                case 25: h-= -1; GOTO++;
                case 26: g = b; GOTO++;
                case 27: g-= c; GOTO++;
                case 28: if (g != 0) { GOTO = 30; break; }; GOTO++;
                case 29: GOTO = 32; break;
                case 30: b-= -17; GOTO++;
                case 31: GOTO = 8; break;
                // @formatter:on
                default:
                    return h;
            }
        }
    }
}
