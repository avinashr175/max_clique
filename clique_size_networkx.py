import networkx as nx
#import matplotlib.pyplot as plt
import numpy as np
from networkx.algorithms.approximation import ramsey
import sys

def create_graph(N,D):
	D=np.array(D)
	G=nx.Graph()
	G.add_nodes_from([0,N-1])
	for i in range(N):
		for j in range(i+1,N):
			if( (np.gcd(j-i,N)) in D):
				G.add_edge(i,j)

	return G
'''def max_clique(G):

    if G is None:
        raise ValueError("Expected NetworkX graph!")

    # finding the maximum clique in a graph is equivalent to finding
    # the independent set in the complementary graph
    cgraph = nx.complement(G)
    iset, _ = clique_removal(cgraph)
    return iset

def clique_removal(G):
    graph = G.copy()
    c_i, i_i = ramsey.ramsey_R2(graph)
    cliques = [c_i]
    isets = [i_i]
    while graph:
        graph.remove_nodes_from(c_i)
        c_i, i_i = ramsey.ramsey_R2(graph)
        if c_i:
            cliques.append(c_i)
        if i_i:
            isets.append(i_i)

    maxiset = max(isets)
    return maxiset, cliques
'''
def get_clique_number(N,D):
	my_graph=create_graph(N,D)
	maxclique=nx.algorithms.clique.graph_clique_number(my_graph)
	return maxclique

if __name__=='__main__':
	D = sys.argv[1].split(',')
	D=[int(x) for x in D]
	N = sys.argv[2]
	N=int(N)
	sys.stdout.write(str(get_clique_number(N,D)))
#	nx.draw(my_graph)
#	plt.show()
