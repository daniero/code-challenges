readtable =: 3 : 0
d =. 1!:1 y
d =. toJ d
d =. cutopen d
d =. 0 ". each d
d =. > d
)

file =. < '../input/input02.txt'
input =: readtable file

echo +/ (>./ - <./) |: input
