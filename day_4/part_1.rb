paper_map = ARGV[0].lines.map{_1.chomp.chars}
movable_paper_count = 0
def adjacent_paper_count(pm,x,y)
  block_arr= []
  (x-1..x+1).each do |ix|
    next unless ix.between?(0,pm[0].size-1)
    (y-1..y+1).each do |iy|
      next unless iy.between?(0,pm.size-1)
      next if ix == x && iy == y
      block_arr << pm[iy][ix]
    end
  end
  block_arr.count("@")
end

paper_map.each_with_index do |x_row, y|
  for x in 0...x_row.size do
    if paper_map[y][x] == "@"
      movable_paper_count += 1 if adjacent_paper_count(paper_map,x,y) < 4
    end
  end
end

movable_paper_count