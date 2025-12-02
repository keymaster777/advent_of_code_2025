INPUT_PATH="part_1_dummy.txt"
DUMMY_INPUT_PATH="part_1_dummy.txt"

lines = IO.read(INPUT_PATH).split("\n")

dial_val = 50
result = 0
lines.each do |instruction|
  chars = instruction.chars
  direction = chars.shift
  val = chars.join.to_i
  val *= -1 unless direction == "R"
  dial_val = (dial_val + val) % 100
  result += 1 if dial_val == 0
end

puts result
