package day23;

class Part2 {
    static long part2() {
        final long C = 124900;

        long h = 0;

        for (long b = 107900; b <= C; b += 17) {
            long f = 1;

            d:
            for (long d = 2; d < b; d++) {
                for (long e = 2; e < b; e++) {
                    if (d * e == b) {
                        f = 0;
                        break d;
                    }
                }
            }

            if (f == 0) {
                h++;
            }
        }
        return h;
    }
}
