package day23;

class Part2 {
    static long part2() {
        final long C = 124900;

        long h = 0;

        for (long b = 107900; b <= C; b += 17) {
            long sqrt = (long) Math.sqrt(b);

            for (long d = 2; d <= sqrt; d++) {
                if (b % d == 0) {
                    h++;
                    break;
                }
            }

        }

        return h;
    }
}
