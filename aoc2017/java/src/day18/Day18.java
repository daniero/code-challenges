package day18;

import java.util.*;

public class Day18 {
    public static void main(String[] args) throws InterruptedException {
        MessageQueue messageQueue = new MessageQueue();
        new Thread(new Program(0, messageQueue)).start();
        new Thread(new Program(1, messageQueue)).start();
    }
}

class Program implements Runnable {
    private final MessageQueue messageQueue;
    private final int id;
    private int messagesSent = 0;
    private long p;

    Program(int id, MessageQueue messageQueue) {
        this.id = id;
        this.p = id;
        this.messageQueue = messageQueue;
    }

    @Override
    public void run() {
        //--- START GENERATED CODE 1
        long i = 0;
        long a = 0;
        long b = 0;
        long f = 0;
        //--- END GENERATED CODE 1

        int GOTO = 0;

        try {
            while (true) {
                switch (GOTO) {
                    //--- START GENERATED CODE 2        @formatter:off
                    case 0: i = 31; GOTO++;
                    case 1: a = 1; GOTO++;
                    case 2: p*= 17; GOTO++;
                    case 3: if (p > 0) { GOTO+= p; break; }; GOTO++;
                    case 4: a*= 2; GOTO++;
                    case 5: i+= -1; GOTO++;
                    case 6: if (i > 0) { GOTO+= -2; break; }; GOTO++;
                    case 7: a+= -1; GOTO++;
                    case 8: i = 127; GOTO++;
                    case 9: p = 680; GOTO++;
                    case 10: p*= 8505; GOTO++;
                    case 11: p%= a; GOTO++;
                    case 12: p*= 129749; GOTO++;
                    case 13: p+= 12345; GOTO++;
                    case 14: p%= a; GOTO++;
                    case 15: b = p; GOTO++;
                    case 16: b%= 10000; GOTO++;
                    case 17: snd(b); GOTO++;
                    case 18: i+= -1; GOTO++;
                    case 19: if (i > 0) { GOTO+= -9; break; }; GOTO++;
                    case 20: if (a > 0) { GOTO+= 3; break; }; GOTO++;
                    case 21: b = rcv(); GOTO++;
                    case 22: if (b > 0) { GOTO+= -1; break; }; GOTO++;
                    case 23: f = 0; GOTO++;
                    case 24: i = 126; GOTO++;
                    case 25: a = rcv(); GOTO++;
                    case 26: b = rcv(); GOTO++;
                    case 27: p = a; GOTO++;
                    case 28: p*= -1; GOTO++;
                    case 29: p+= b; GOTO++;
                    case 30: if (p > 0) { GOTO+= 4; break; }; GOTO++;
                    case 31: snd(a); GOTO++;
                    case 32: a = b; GOTO++;
                    case 33: if (1 > 0) { GOTO+= 3; break; }; GOTO++;
                    case 34: snd(b); GOTO++;
                    case 35: f = 1; GOTO++;
                    case 36: i+= -1; GOTO++;
                    case 37: if (i > 0) { GOTO+= -11; break; }; GOTO++;
                    case 38: snd(a); GOTO++;
                    case 39: if (f > 0) { GOTO+= -16; break; }; GOTO++;
                    case 40: if (a > 0) { GOTO+= -19; break; }; GOTO++;
                    //--- END GENERATED CODE 2          @formatter:on
                    default:
                        throw new IllegalStateException("Huh..");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            System.out.printf("Program %d sent %d messages\n", id, messagesSent);
            System.exit(0);
        }
    }

    private void snd(long b) {
        messagesSent++;
        messageQueue.snd(id, b);
    }

    private Long rcv() {
        return messageQueue.rcv(id);
    }
}

class MessageQueue {
    private int waiting = 0;
    private List<ArrayDeque<Long>> queues = Arrays.asList(new ArrayDeque<Long>(), new ArrayDeque<Long>());

    synchronized void snd(int fromId, long value) {
        //System.out.printf("program %d sends %d%n", fromId, value);
        queues.get(1 - fromId).addLast(value);
        notifyAll();
    }

    synchronized Long rcv(int toId) {
        if (++waiting == 2 && queues.stream().allMatch(ArrayDeque::isEmpty)) {
            throw new Deadlock();
        }

        Deque<Long> queue = queues.get(toId);
        while (queue.isEmpty()) {
            try {
                //System.out.printf("program %d waits%n", toId);
                wait();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        waiting--;
        Long value = queue.removeFirst();
        //System.out.printf("program %d received %d%n", toId, value);
        return value;
    }

    private class Deadlock extends RuntimeException {
    }

}
