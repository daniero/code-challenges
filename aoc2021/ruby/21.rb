TEST = false

if TEST
  player1_pos = 4
  player2_pos = 8
else
  player1_pos = 8
  player2_pos = 6
end


POSITIONS = 10

def player(position, score)
  (position-1) + POSITIONS * score
end

def score(player)
  player / POSITIONS
end

def position(player)
  player % POSITIONS + 1
end

def new_position(current, move)
  new_pos = current + move
  mod = new_pos % POSITIONS
  mod == 0 ? POSITIONS : mod
end


INITIAL_STATE = [
  player(player1_pos, 0),
  player(player2_pos, 0),
]


# Part 1

turns = 0
deterministic_d100 = (1..100).cycle
current_player, next_player = INITIAL_STATE

loop do
  turns += 1
  rolls = 3.times.sum { deterministic_d100.next }

  new_pos = new_position(position(current_player), rolls)
  new_score = score(current_player) + new_pos

  current_player, next_player = next_player, player(new_pos, new_score)

  break if new_score >= 1000
end

part1 = score(current_player) * turns * 3
puts part1


# Part 2

WIN = 21
dirac_dice = [1,2,3].repeated_permutation(3)
rolls = dirac_dice.map(&:sum).tally

wins = [0, 0]
turns = { INITIAL_STATE => 1 }

0.step do |i|
  next_turns = Hash.new(0)

  turns.each { |(current_player, next_player), incoming_paths|
    rolls.each { |roll, tally|
      new_paths = incoming_paths * tally

      new_pos = new_position(position(current_player), roll)
      new_score = score(current_player) + new_pos

      if new_score >= WIN
        wins[i%2] += new_paths
      else
        new_state = [next_player, player(new_pos, new_score)]
        next_turns[new_state] += new_paths
      end
    }
  }

  break if next_turns.empty?
  turns = next_turns
end

part2 = wins.max
puts part2

