`cat i`.lines.sum{c=_1.chomp.chars;a=[];12.times{|i|a<<c[0..i-12].max;c=c[c.index(a[-1])+1..]};a.join.to_i}
