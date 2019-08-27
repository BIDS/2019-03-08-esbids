"""
Creates sample migration matrices. Each node in a given network must have a migration matrix. 

TODO: 
(1) Create realistic matrices - currently, all three samples are the same imaginary scenario for testing purposes. 
"""


## Migration_matrix: [number of states (# genotypes x states in each lifestage), number of nodes, number of nodes]

migrate_far = rand((6*(4+8+6+1+6)), 2, 2) 

migrate_mid = rand((6*(4+8+6+1+6)), 2, 2) 

migrate_near = rand((6*(4+8+6+1+6)), 2, 2)