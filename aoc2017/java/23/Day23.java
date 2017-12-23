public class Day23 {
    public static void main(String[] args) {
        //System.out.println(part1());
        System.out.println(part2());
    }

    private static int part1() {
        long a = 0;
        long b = 0;
        long c = 0;
        long d = 0;
        long e = 0;
        long f = 0;
        long g = 0;
        long h = 0;

        int go = 0;
        int mul = 0;

        while (true)
            switch (go) {
                // @formatter:off
                case 0: b = 79; go++;
                case 1: c = b; go++;
                case 2: if (a != 0) { go = 4; break; }; go++;
                case 3: go = 8; break;
                case 4: mul++; b*= 100; go++;
                case 5: b-= -100000; go++;
                case 6: c = b; go++;
                case 7: c-= -17000; go++;
                case 8: f = 1; go++;
                case 9: d = 2; go++;
                case 10: e = 2; go++;
                case 11: g = d; go++;
                case 12: mul++; g*= e; go++;
                case 13: g-= b; go++;
                case 14: if (g != 0) { go = 16; break; }; go++;
                case 15: f = 0; go++;
                case 16: e-= -1; go++;
                case 17: g = e; go++;
                case 18: g-= b; go++;
                case 19: if (g != 0) { go = 11; break; }; go++;
                case 20: d-= -1; go++;
                case 21: g = d; go++;
                case 22: g-= b; go++;
                case 23: if (g != 0) { go = 10; break; }; go++;
                case 24: if (f != 0) { go = 26; break; }; go++;
                case 25: h-= -1; go++;
                case 26: g = b; go++;
                case 27: g-= c; go++;
                case 28: if (g != 0) { go = 30; break; }; go++;
                case 29: go = 32; break;
                case 30: b-= -17; go++;
                case 31: go = 8; break;
                // @formatter:on
                default:
                    return mul;
            }
    }

    private static long part2() {
        long b = 0;
        long c = 0;
        long d = 0;
        long e = 0;
        long f = 0;
        long g = 0;
        long h = 0;

        int GOTO = 0;

        while (true) {
            switch (GOTO) {
                // @formatter:off
                case 0: b = 79; GOTO++;
                case 1: c = b; GOTO++;
                case 2: GOTO = 4; break;
                case 3: GOTO = 8; break;
                case 4: b*= 100; GOTO++;
                case 5: b-= -100000; GOTO++;
                case 6: c = b; GOTO++;
                case 7: c-= -17000; GOTO++;
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

