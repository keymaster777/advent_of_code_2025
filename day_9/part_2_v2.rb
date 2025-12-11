# Check me
# 1574684850
Coord = Struct.new(:x, :y) do
  def area_with(other_coord)
    width = (other_coord.x - x).abs+1
    height = (other_coord.y - y).abs+1
    width * height
  end

  def inside_polygon?(polygon_arr)
    return CHECKED_COORDS[[x,y]] if CHECKED_COORDS.has_key?([x,y])

    inside = false
    polygon_arr.each_with_index do |p1, i|
      p2 = polygon_arr[(i + 1) % polygon_arr.length]
      if falls_between?(p1, p2)
        CHECKED_COORDS[[x,y]] = true
        return true
      end

      if ((p1.y > y) != (p2.y > y)) && (x < (p2.x - p1.x) * (y - p1.y) / (p2.y - p1.y) + p1.x)
        inside = !inside
      end
    end

    CHECKED_COORDS[[x,y]] = inside
    inside
  end

  def falls_between?(coord_a, coord_b)
    [x, coord_a.x, coord_b.x].uniq.size == 1 && y.between?(*[coord_a.y, coord_b.y].sort) ||
      [y, coord_a.y, coord_b.y].uniq.size == 1 && x.between?(*[coord_a.x, coord_b.x].sort)
  end
end

CHECKED_COORDS = {}
def valid_square?(coord_a, coord_b)
  min_x, max_x = *[coord_a.x, coord_b.x].sort
  min_y, max_y = *[coord_a.y, coord_b.y].sort

  center = Coord.new((min_x + max_x) / 2, (min_y + max_y) / 2)
  corners = [
    Coord.new(min_x, min_y),
    Coord.new(max_x, min_y),
    Coord.new(max_x, max_y),
    Coord.new(min_x, max_y),
  ]

  return false if (corners + [center]).any? { |coord| !coord.inside_polygon?(COORDS) }

  corners.each_with_index do |coord, i|
    coord2 = corners[(i + 1) % corners.size]
    line = [coord, coord2]

    if line[0].x == line[1].x # vertical
      x = line[0].x
      y1, y2 = [line[0].y, line[1].y].sort
      HORIZONTAL_LINES.each do |h_line|
        hy = h_line[0].y
        hx1, hx2 = [h_line[0].x, h_line[1].x].sort
        return false if (hx1 < x && x < hx2) && (y1 < hy && hy < y2)
      end
    elsif line[0].y == line[1].y # horizontal
      y = line[0].y
      x1, x2 = [line[0].x, line[1].x].sort
      VERTICAL_LINES.each do |v_line|
        vx = v_line[0].x
        vy1, vy2 = [v_line[0].y, v_line[1].y].sort
        return false if (vy1 < y && y < vy2) && (x1 < vx && vx < x2)
      end
    end
  end

  true
end

start_time = Time.now
parsed_input = ARGV[0].lines.map{_1.chomp.split(",").map(&:to_i)}
coords = parsed_input.map{|x, y| Coord.new(x, y)}
COORDS = coords

HORIZONTAL_LINES = []
VERTICAL_LINES = []

coords.each_with_index do |coord, i|
  coord2 = coords[(i+1) % coords.size]
  if coord.x == coord2.x
    VERTICAL_LINES << [coord, coord2]
  elsif coord.y == coord2.y
    HORIZONTAL_LINES << [coord, coord2]
  end
end
largest_area = 0

for coord_a in 0...coords.size
  #puts "Percent complete: #{(coord_a.to_f / coords.size.to_f) * 100}"
  for coord_b in coord_a+1...coords.size
    area = coords[coord_a].area_with(coords[coord_b])
    if area > largest_area
      valid = valid_square?(coords[coord_a], coords[coord_b])
      #puts "Area #{area} valid #{valid}, coord: #{coords[coord_a]} #{coords[coord_b]}"
      if valid
        largest_area = area
      end
    end
  end
end

puts "Took #{Time.now - start_time} seconds"
largest_area
