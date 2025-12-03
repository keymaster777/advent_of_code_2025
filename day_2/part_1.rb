DUMMY_INPUT_PATH="part_1_dummy.txt"
INPUT_PATH="i"
ranges = File.read(INPUT_PATH).split(",")
total = 0

def bad_id_range_sum(range_str)
  range_sum = 0
  range_start = range_str.split("-")[0].to_i
  range_end = range_str.split("-")[1].to_i

  (range_start..range_end).each do |ele|
    ele_size = ele.to_s.size
    next if ele_size % 2 == 1
    half_size = ele_size / 2
    range_sum += ele if ele.to_s[0, half_size] == ele.to_s[half_size, half_size]
  end

  range_sum
end

ranges.each do |id_range|
  total += bad_id_range_sum(id_range)
end

puts total
