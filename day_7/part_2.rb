INPUT_LINES = ARGV[0].lines.map{_1.chomp.chars}
MEMO = {}

def recursive_get_paths(x, y)
  i=1;loop do
    next_y = y + i
    return 1 if next_y == INPUT_LINES.size - 1
    return MEMO[[x, next_y]] if MEMO[[x, next_y]]

    if INPUT_LINES[next_y][x] == '^'
      left  = (x > 0) ? recursive_get_paths(x - 1, next_y) : 0
      right = (x + 1 < INPUT_LINES[0].size) ? recursive_get_paths(x + 1, next_y) : 0
      MEMO[[x, next_y]] = left + right
      return MEMO[[x, next_y]]
    end

    i += 1
  end
end

recursive_get_paths(INPUT_LINES[0].index('S'), 0)