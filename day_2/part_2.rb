DUMMY_INPUT_PATH="part_1_dummy.txt"
INPUT_PATH="part_1_input.txt"
ranges = File.read(INPUT_PATH).split(",")

def invalid_id_check(id)
  return 0 if id.size == 1
  for i in 0...(id.size/2.0).floor do
    grouped = id.each_slice(i+1).to_a
    return id.join.to_i if grouped.all? {|group| group == grouped[0]}
  end
  0
end

bad_sum = ->(range) {(range[0]..range[1]).sum {|ele| invalid_id_check(ele.to_s.chars)}}
ranges.sum{|ele| bad_sum.call(ele.split("-").map(&:to_i))}