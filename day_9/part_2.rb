# Too high
# 4629504600
# Too Low
# 135371390
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
def valid_square?(coord_a, coord_b, polygon_arr)
  top_left = Coord.new([coord_a.x, coord_b.x].min, [coord_a.y, coord_b.y].min)
  bottom_right = Coord.new([coord_a.x, coord_b.x].max, [coord_a.y, coord_b.y].max)

  for y in top_left.y..bottom_right.y
    for x in top_left.x..bottom_right.x
      unless CHECKED_COORDS.has_key?([x,y])
        CHECKED_COORDS[[x,y]] = Coord.new(x, y).inside_polygon?(polygon_arr)
      end
      return false if CHECKED_COORDS[[x,y]] == false
    end
  end
  true
end

def valid_square_v2?(coord_a, coord_b, polygon_arr)
  corners = [
    Coord.new([coord_a.x, coord_b.x].min, [coord_a.y, coord_b.y].min),
    Coord.new([coord_a.x, coord_b.x].min, [coord_a.y, coord_b.y].max),
    Coord.new([coord_a.x, coord_b.x].max, [coord_a.y, coord_b.y].max),
    Coord.new([coord_a.x, coord_b.x].max, [coord_a.y, coord_b.y].min)
  ]
  corners.all?{|coord| coord.inside_polygon?(polygon_arr)}
end

def valid_square_v3?(coord_a, coord_b, polygon_arr)
  edges = []
  min_x, max_x = *[coord_a.x, coord_b.x].sort
  min_y, max_y = *[coord_a.y, coord_b.y].sort

  return false if [
    Coord.new(min_x, min_y),
    Coord.new(min_x, max_y),
    Coord.new(max_x, max_y),
    Coord.new(max_x, min_y)
  ].any?{|coord| !coord.inside_polygon?(polygon_arr)}

  for x in min_x..max_x
    edges << Coord.new(x, min_y)
    edges << Coord.new(x, max_y)
  end
  for y in min_y..max_y
    edges << Coord.new(min_x, y)
    edges << Coord.new(max_x, y)
  end
  edges.all?{|coord| coord.inside_polygon?(polygon_arr)}
end

parsed_input = ARGV[0].lines.map{_1.chomp.split(",").map(&:to_i)}
coords = parsed_input.map{|x, y| Coord.new(x, y)}
largest_area = 0

for i in 0...coords.size
  coord_a = coords[i]
  coord_b = coords[(i+2) % coords.size]
  area = coord_a.area_with(coord_b)
  if area > largest_area
    valid = valid_square_v3?(coord_a, coord_b, coords)
    largest_area = area if valid
  end
end

#for coord_a in 0...coords.size
#  puts "Percent complete: #{(coord_a.to_f / coords.size.to_f) * 100}"
#  for coord_b in coord_a+1...coords.size
#    #puts "#{coord_a} #{coord_b} area #{coords[coord_a].area_with(coords[coord_b])}"
#    area = coords[coord_a].area_with(coords[coord_b])
#    if area > largest_area
#      #puts("Checking square #{coord_a} #{coord_b} area #{area}, current largest #{largest_area}")
#      valid = valid_square_v3?(coords[coord_a], coords[coord_b], coords)
#      largest_area = area if valid
#    end
#  end
#end

def visual_test(coords)
  test_result = []
  for y in 0..coords.max_by(&:y).y do
    outstring = ""
    for x in 0..coords.max_by(&:x).x do
      if Coord.new(x,y).inside_polygon?(coords)
        outstring += "X"
      else
        outstring += "O"
      end
      if coords.map{|coord|"#{coord.x},#{coord.y}"}.include?("#{x},#{y}")
        outstring[-1] = "*"
      end
    end
    test_result << outstring
  end

  test_result.each do |line| puts line end
end

#visual_test(coords)

largest_area
