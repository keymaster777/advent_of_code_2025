#Working
#IO.read("i").split("\n").sum{|line|c=line.chars;a=[];for i in 0...12 do a<<c[0..(12-i)*-1].max;c=c[c.index(a.last)+1..]end;a.join.to_i}
#
#IO.read("i").split("\n").sum{|line|c=line.chars;a=[];for i in 0...12 do a<<c[0..(12-i)*-1].max;c=c[c.index(a.last)+1..]end;a.join.to_i}

#t=0;IO.foreach('i'){|l|c=l.chop.chars;a=[];for i in 0..11 do a<<c[0..(12-i)*-1].max;c=c[c.index(a[-1])+1..]end;t+=a.join.to_i};t

#IO.read("i").split("\n").sum{|l|c=l.chars;a=[];for i in 0..11 do a<<c[0..(12-i)*-1].max;c=c[c.index(a[-1])+1..]end;a.join.to_i}
#IO.read("i").split("\n").sum{|l|c=l.chars;a=[];(0..11).each{|i| a<<c[0..(12-i)*-1].max;c=c[c.index(a[-1])+1..]};a.join.to_i}

#IO.read("i").split("\n").sum{|l|c=l.chars;a=[];(0..11).each{|i|a<<c[0..-12+i].max;c=c[c.index(a[-1])+1..]};a.join.to_i}
#IO.read("i").split(?\n).sum{c=_1.chars;a=[];(0..11).map{|i|a<<c[0..-12+i].max;c=c[c.index(a[-1])+1..]};a.join.to_i}
#IO.read("i").split(?\n).sum{c=_1.chars;a=[];12.times{|i|a<<c[0..-12+i].max;c=c[c.index(a[-1])+1..]};a.join.to_i}
`cat i`.lines.sum{c=_1.chomp.chars;a=[];12.times{|i|a<<c[0..-12+i].max;c=c[c.index(a[-1])+1..]};a.join.to_i}
