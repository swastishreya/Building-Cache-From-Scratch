import matplotlib.pyplot as plt
import re

hitList = []
accessList = []
s = raw_input()
while(s != "\n"):
    s = re.sub(' +', ' ',s)
    hits, misses = map(int, s.strip().split(" "))
    hitList.append(hits)
    accessList.append(hits+misses)
    print s
    s = raw_input()
    if(s == "EOF"):
        break
    s = raw_input()

print hitList
print accessList
plt.ylabel('Hits')
plt.xlabel('Total access')
plt.scatter(accessList,hitList,50)
plt.show()