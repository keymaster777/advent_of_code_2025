lines = $*[0].lines.map{_1.chomp}
fresh_ranges = lines[0...lines.index("")].map{_1.split("-").map(&:to_i)}
end_check = 0

fresh_ranges.sort_by{|ele| ele[0]}.sum do |range|
  start_check = [end_check+1, range[0]].max
  start_check > range[1] ? 0 : (end_check = range[1]; range[1]-start_check+1)
end