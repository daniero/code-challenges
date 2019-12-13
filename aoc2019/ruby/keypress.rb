require 'io/console'

SPACE = " "
TAB = "\t"
RETURN = "\r"
LINE_FEED = "\n"
ESCAPE = "\e"
UP_ARROW = "\e[A"
DOWN_ARROW = "\e[B"
RIGHT_ARROW = "\e[C"
LEFT_ARROW = "\e[D"
BACKSPACE = "\177"
DELETE = "\004"
ALTERNATE_DELETE = "\e[3~"
CTRL_C = "\u0003"

def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return nil if input == ESCAPE
  return input
end

