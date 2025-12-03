INPUT_PATH="part_1_input.txt"
DUMMY_INPUT_PATH="part_1_dummy.txt"
lines = IO.read(INPUT_PATH).split("\n")

total = 0

lines.each do |line|
  chars = line.chars
  joltage_first = chars[0..-2].max
  joltage_second = chars[chars.index(joltage_first)+1..].max
  total += "#{joltage_first}#{joltage_second}".to_i
end

total