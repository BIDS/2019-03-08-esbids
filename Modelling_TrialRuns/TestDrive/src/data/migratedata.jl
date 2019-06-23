"""
Create migration matrices for each node in desired network. 

Question: Should this be included as an example, rather than built into the package? 
"""


## Migration_matrix: [number of states (# genotypes x states in each lifestage), number of nodes, number of nodes]
migrate_matrix_node1 = rand((6*(4+8+6+1+6)), 2, 2) 
migrate_matrix_node2 = rand((6*(4+8+6+1+6)), 2, 2)