#f=->i{o=$*[0].lines.map{_1.chomp.split ": "}.map{[_1[0],_1[1].split]}.to_h[i];o==["out"]?1:o.sum{f[_1]}}
#f=->i{o=$*[0].scan(/(\w+): (.+)/).map{[_1[0],_1[1].split]}.to_h[i];o==["out"]?1:o.sum{f[_1]}}
#f=->i{o=$*[0].scan(/(\w+): (.+)/).to_h[i].split;o==['out']?1:o.sum{f[_1]}};f['you']

# Final version 78 chars
#h=$*[0].scan(/(\w+): (.+)/).to_h;f=->i{h[i].split.sum{f[_1]}rescue 1};f['you']
