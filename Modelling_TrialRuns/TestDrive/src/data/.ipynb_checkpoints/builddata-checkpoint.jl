"""

Question: Should all of this be in the "example" where an imaginary population is created calling all the pkg pieces? 

Question: If "yes" to above, how to always store stages in a dict with integer keys so I know where they are (this way, 
never out of order, eggs always 1 and males always 4 even if all juveniles removed)

"""

## Build stages 
stages_dict = Dict{Int64, Stage}(1 => Stage(Egg, 4., (1/4.), 4, 0.5, nothing, 0),
                                 2 => Stage(Larvae, 3., (1/3.), 8, 0.15, 355.0, 0), 
                                 3 => Stage(Pupae, 6., (1/6.), 6, 0.05, nothing, 0),
                                 4 => Stage(Male, nothing, nothing, nothing, 0.09, nothing, 0),
                                 5 => Stage(Female, nothing, nothing, nothing, 0.09, nothing, 500),
)

## Name nodes 
firstnode = :FirstNode
secondnode = :SecondNode

## Build nodes using stages and node information (above): [name, gene_data, stages, location, migration_matrix]
nodes = [Node(:FirstNode, genetics, stages_dict, (37.87, 122.27), migrate_matrix_node1),
         Node(:SecondNode, genetics, stages_dict, (35.87, 120.27), migrate_matrix_node2)]

## Build network: [nodes, total states] 
network = Network(nodes, 150)

