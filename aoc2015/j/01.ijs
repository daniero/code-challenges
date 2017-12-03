input =: 1!:1 < '../input/01.txt'

moves =: 1 - 2 * ')' = input

NB. Part 1
echo +/ moves

NB. Part 2
echo 1 + (+/\ moves) i. _1
