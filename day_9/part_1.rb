
Coord = Struct.new(:x, :y) do
  def area_with(other_coord)
    width = (other_coord.x - x).abs+1
    height = (other_coord.y - y).abs+1
    width * height
  end

end

parsed_input = ARGV[0].lines.map{_1.chomp.split(",").map(&:to_i)}
coords = parsed_input.map{|x, y| Coord.new(x, y)}
largest_area = 0

for coord_a in 0...coords.size
  for coord_b in coord_a+1...coords.size
    #puts "#{coord_a} #{coord_b} area #{coords[coord_a].area_with(coords[coord_b])}"
    area = coords[coord_a].area_with(coords[coord_b])
    if area > largest_area
      largest_area = area
    end
  end
end

largest_area