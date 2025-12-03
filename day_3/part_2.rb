INPUT_PATH="i"
DUMMY_INPUT_PATH="part_1_dummy.txt"
lines = IO.read(INPUT_PATH).split("\n")

total = 0

lines.each do |line|
  chars = line.chars
  result_arr = []
  for i in 0...12 do
    result_arr << chars[0..(12-i)*-1].max
    chars = chars[chars.index(result_arr.last)+1..]
  end
  total += result_arr.join.to_i
end

total