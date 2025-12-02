d=50;s=0;IO.foreach('p.t'){|l|v=l[1..].to_i;w=v/100;r=v%100;r=-r if l[0]!="R";n=d+r;w+=1 if n>99||(n<=0&&d>0);d=n%100;s+=w};s
