input_lines = ARGV[0].lines.map{_1.chomp.chars}
split_count = 0

for i in 1...input_lines.size
  for ib in 0...input_lines[i].size
    if ["|", "S"].include? input_lines[i-1][ib]
      current_char = input_lines[i][ib]
      if current_char == "."
        input_lines[i][ib] = "|"
      elsif current_char == "^"
        split_count += 1
        input_lines[i][ib-1] = "|" if ib-1 >= 0
        input_lines[i][ib+1] = "|" if ib+1 < input_lines[i].size
      end
    end
  end
end

# Visual check
# input_lines.each{p _1.join}

split_count