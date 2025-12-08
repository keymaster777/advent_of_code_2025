

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
groups = []

paired_coords = []
max_idx = nil

(0..coords.size).each do |i|
  (i+1...coords.size).each do |j|
    d2 = coords[i].distance_to(coords[j])**2
    if paired_coords.size < $*[1].to_i
      paired_coords << [d2, i, j]
      if max_idx.nil? || paired_coords[max_idx][0] < d2
        max_idx = paired_coords.size - 1
      end
    else
      if d2 < paired_coords[max_idx][0]
        paired_coords[max_idx] = [d2, i, j]
        max_idx = 0
        (1...paired_coords.size).each do |t|
          max_idx = t if paired_coords[t][0] > paired_coords[max_idx][0]
        end
      end
    end
  end
end

paired_coords.sort_by!{|d2, i, j| d2}.each_with_index do |(d2, i, j), idx|
  puts "#{idx} #{d2} #{coords[i].to_s} #{coords[j].to_s}"
end

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
end

groups.map{_1.flatten.uniq.size}.sort.last(3).inject(:*)
