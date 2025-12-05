paper_map = ARGV[0].lines.map{_1.chomp.chars}
movable_paper_count = 0

def adjacent_papers(elf_map,x,y)
  [[x-1,y],[x+1,y],[x,y-1],[x,y+1],[x-1,y-1],[x-1,y+1],[x+1,y-1],[x+1,y+1]]
    .filter{|x,y| [x,y].all?{_1.between?(0, elf_map.size-1)}}
    .count{|x,y| elf_map[y][x] == "@"}
end

loop do
  deletions = []
  paper_map.each_with_index do |x_row, y|
    x_row.size.times do |x|
      deletions << [x,y] if paper_map[y][x] == "@" && adjacent_papers(paper_map,x,y) < 4
    end
  end

  break if deletions.empty?
  movable_paper_count += deletions.size
  deletions.each{|x,y| paper_map[y][x] = "."}
end

movable_paper_count