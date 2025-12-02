INPUT_PATH="part_1_dummy.txt"
DUMMY_INPUT_PATH="part_1_dummy.txt"
lines = IO.read(INPUT_PATH).split("\n")

dial_val = 50
result = 0

lines.each do |line|
  instruction = line.chars
  direction = instruction.shift
  val = instruction.join.to_i

  wrap_count = (val / 100.0).floor
  remainder = val % 100
  remainder *= -1 unless direction == "R"
  no_limit_dial = dial_val + remainder

  wrap_count +=1 if (no_limit_dial > 99 || (no_limit_dial <= 0 && dial_val != 0))

  dial_val = no_limit_dial % 100
  result += wrap_count
end

puts result
