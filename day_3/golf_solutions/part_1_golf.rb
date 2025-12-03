`cat i`.lines.sum{c=_1.chomp.chars;f=c[0..-2].max;(f+c[c.index(f)+1..].max).to_i}
