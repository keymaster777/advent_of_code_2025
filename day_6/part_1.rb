input_lines = ARGV[0].lines.map{_1.split}
evaluations = input_lines[0].size
count = 0

evaluations.times do |i|
  nums = input_lines.map{_1[i]}
  operation = nums.pop()
  nums = nums.map(&:to_i)

  if operation == "+"
    count += nums.sum
  elsif operation == "*"
    count += nums.inject(:*)
  else
    puts "Unknown operation: #{operation}"
  end
end

count