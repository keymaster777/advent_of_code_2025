

Coord = Struct.new(:x, :y, :z) do
  def distance_to(other_coord)
    dx = other_coord.x - x;
    dy = other_coord.y - y;
    dz = other_coord.z - z
    (dx**2 + dy**2 + dz**2)**0.5
  end

  def to_s
    "#{x},#{y},#{z}"
  end
end

parsed_input = ARGV[0].lines.map{_1.chomp.split(",").map(&:to_i)}
coords = parsed_input.map{|x, y, z| Coord.new(x, y, z)}
final_connection = nil
groups = []

paired_coords = []
max_idx = nil

(0..coords.size).each do |jct_1|
  (jct_1+1...coords.size).each do |jct_2|
    dist = coords[jct_1].distance_to(coords[jct_2])**2
    if paired_coords.size < $*[1].to_i
      paired_coords << [dist, coords[jct_1], coords[jct_2]]
      if max_idx.nil? || paired_coords[max_idx][0] < dist
        max_idx = paired_coords.size - 1
      end
    else
      if dist < paired_coords[max_idx][0]
        paired_coords[max_idx] = [dist, coords[jct_1], coords[jct_2]]
        max_idx = 0
        (1...paired_coords.size).each do |t|
          max_idx = t if paired_coords[t][0] > paired_coords[max_idx][0]
        end
      end
    end
  end
end

paired_coords.sort_by!{|d2, i, j| d2}

$*[1].to_i.times do |i|
  break if paired_coords.empty?
  pair = paired_coords.shift
  pair = [pair[1], pair[2]]

  group_match_a = groups.find{|group| group.flatten.include?(pair[0].to_s)}
  group_match_b = groups.find{|group| group.flatten.include?(pair[1].to_s)}

  if group_match_a && group_match_b
    if group_match_a != group_match_b
      group_match_a.concat(group_match_b)
      groups.delete(group_match_b)
    end

  elsif group_match_a
    group_match_a << [pair[0].to_s, pair[1].to_s]
  elsif group_match_b
    group_match_b << [pair[0].to_s, pair[1].to_s]
  else
    groups << [[pair[0].to_s, pair[1].to_s]]
  end

  if groups.size == 1 && groups.flatten.uniq.size == coords.size
    final_connection = pair
    break
  end
end

final_connection[0].x * final_connection[1].x