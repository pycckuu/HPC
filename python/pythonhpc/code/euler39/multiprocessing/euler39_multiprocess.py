from multiprocessing import Pool
import find_num_solutions

p= Pool (processes=4)

y=range(1,1000)
results = p.map(find_num_solutions.find_num_solutions,y)
print "answer",y[results.index(max(results))]

