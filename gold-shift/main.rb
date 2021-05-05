M,B=Math,0
def tick a
s=a.outputs.solids
s<<[0,0,C=1e4,C]
B+=a.tick_count.cos/1e3
110.step(610,12){|y|390.step(890,12){|x|e=((M.sin(y*B)+(M.cos(x-B)))*l=200)+((M.sin(x*B)+(M.cos(y-B)))*l)
s<<[x,y,6,6,r=e.abs,r/2,r/3]}}end