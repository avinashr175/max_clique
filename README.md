# max_clique
We are trying to find the max-clique size in appropriately defined graphs (gcd graphs in this case) containing N vertices, where N is of the form p<sub>1</sub><sup>M<sub>1</sub></sup>p<sub>2</sub><sup>M<sub>2</sub></sup>. Here p<sub>1</sub> and 
p<sub>2</sub> are prime numbers. Also, without loss of generality we can consider p<sub>1</sub> < p<sub>2</sub>

# Construction of graph from given N and divisor set D
D is a list of divisors. Any element of D is of the form p<sub>1</sub><sup>a</sup>p<sub>2</sub><sup>b</sup> where 0<=a<M<sub>1</sub> and 0<=b<M<sub>2</sub>. There exists a edge between vertices i and j iff gcd(i-j,N) is an element of D.

# Description of the files

The main module is the maximum_clique_size.m . We have also written a script (maximum_clique_size_gcd.m) to catch out exceptions in which our algorihtm fails. We use NetworkX which is a python package to compute the max clique size accurately. Note that it's computational complexity is of exponential order. The failing test cases have been noted down in the exceptions text file.
