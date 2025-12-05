input_lines = ARGV[0].lines.map{_1.chomp}
split_index = input_lines.index("")
fresh_ranges = input_lines[0..split_index-1].map{|ele| ele.split("-").map(&:to_i)}
ingredients = input_lines[split_index+1..].map(&:to_i)

fresh_count = 0

ingredients.each do |ingredient_int|
  fresh_ranges.each do |range|
    if ingredient_int.between?(range[0], range[1])
      fresh_count += 1
      break
    end
  end
end

fresh_count