# Golfed pt2 first, basing this off that solution
#`cat i`.lines.sum{c=_1.chomp.chars;12.times{|i|a<<c[0..-12+i].max;c=c[c.index(a[-1])+1..]};a.join.to_i}
#`cat i`.lines.sum{c=_1.chomp.chars;"#{c[0..-2].max}#{c[c.index(c[0..-2].max)+1..].max}".to_i}
#`cat i`.lines.sum{c=_1.chomp.chars;f=c[0..-2].max;"#{f}#{c[c.index(f)+1..].max}".to_i}
`cat i`.lines.sum{c=_1.chomp.chars;f=c[0..-2].max;(f+c[c.index(f)+1..].max).to_i}
