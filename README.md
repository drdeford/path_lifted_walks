# Lifted Walks on Paths

This repo contains the source code for my interactive exploring <b>Example 1.1</b> presented in the paper 
<a href="http://www.math.ucla.edu/~pak/papers/stoc2.pdf">Lifting Markov Chains to Speed up Mixing
 </a> by Chen, Lovasz, and Pak. The interactive tool and some additional discussion of the theoretical details are <a href="https://people.csail.mit.edu/ddeford/lifted_walks.html"> here</a>. The tool computes an arbitrary projection of the cycle onto the path, shows that the stationary distribution is correct and then samples both walks to compare their respective mixing times. 
 
 
The first two figures show the 6-path and 10-cycle with the nodes colored to correspond to a random projection from the cycle to the path, with the property that each endpoint of the path is mapped to by a single node of the cycle and each other node of the path is mapped to by two nodes of the cycle. 
 
 
   ![alt text](https://github.com/drdeford/path_lifted_walks/blob/master/Figures/p6.png "The 6-path. ")

  ![alt text](https://github.com/drdeford/path_lifted_walks/blob/master/Figures/cycle_random.png "A random projection. ")

The projection mapping here means that if we are on a particular color on the cycle, then we get mapped down to the correspondingly colored node on the path:

   ![alt text](https://github.com/drdeford/path_lifted_walks/blob/master/Figures/project_schematic.png "The projection schematic. ")

We can form a new random walk on the nodes of the path by randomly choosing one node of the same color on the cycle, moving to a neighbor along the cycle, and then projecting back down to the path, as shown below. 

   ![alt text](https://github.com/drdeford/path_lifted_walks/blob/master/Figures/walk_schematicc.png "The lifted walk. ")
   
   This new walk has the same stationary distribution as the simple random walk on the path but mixes more rapidly, even though the intermediate graph has more nodes than the original!

