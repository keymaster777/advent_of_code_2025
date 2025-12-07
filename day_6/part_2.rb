lines = ARGV[0].lines
operations = lines.pop.split
column_nums = []
count = 0

for i in 0..lines[0].size do
  column = lines.map{_1[i]}.join
  if column.strip == ""
    break if operations.empty?
    operation = operations.shift
    count += operation == "+" ? column_nums.sum : column_nums.inject(:*)
    column_nums = []
  else
    column_nums << column.to_i
  end
end

count