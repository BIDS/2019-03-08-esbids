"""
Includes Node and Network. 

TODO: 
(1) Geography: node location and network layout. How?
(2) Migration: as noted in migratedata file, need to develop realistic examples. 
"""

## Node

struct Node 
    
    name::Symbol                     # Name of node (eg, neighborhood)
    gene_data::Genetics              # Genetic information for entire population in node
    all_stages::Vector{Stage}        # OR Dict{Int64, Stage} ? Array of all stages present in node
    temperature::Temp                # Flexible temperature function specification 
    location::Tuple{Float64,Float64} # Coordinates of geographic location 
    migration::Array{Float64,3}      #2 vs 3     # Tensor with each slice applicable to one state's (state = genotype x stage) movement where [state, node_from, node_to] -> QUESTION: make this a matrix instead because just relevant to one node? Compile all using function rather than employing another field in the Network struct to assemble them (since will only use for analysis purposes anyway)

end


## Network 
struct Network
    
    all_nodes::Vector{Node}
    all_locations::Vector{Tuple{Float64, Float64}}                      
    net_migration::Array{Float64,4}  #3 vs 4 # Need one matrix per "state" (state = genotype x stage pair) -> 
                                     # therefore one cube per node (migration for all states) ->
                                     # therefore must add a fourth dimension to encompass network 
    
    function Network(all_nodes::Vector{Node}, n_states::Int64)   
        
        n_nodes = length(all_nodes)
        
        all_locations = Vector{Tuple{Float64,Float64}}(undef, n_nodes)     
        net_migration = Array{Float64,4}(undef, n_nodes, n_states, n_nodes, n_nodes) 
        
        for (index, n) in enumerate(all_nodes) 
            all_locations[index] = n.location
            net_migration[index, :, :, :] = n.migration # , :] #returns a 3x3xindex tensor specific to each node -> instead write a get_ function that accumulates all the nodes info 
        end
        
        new(all_nodes, all_locations, net_migration) 
        
    end
    
end

#######################
# Get/access functions 
#######################


############## For network 

function get_nodes(network::Network)
    return network.all_nodes 
end

############## For stages 

get_allstages(node::Node) = node.all_stages


function get_stage(stage_array::Vector{Stage}, life_stage::Type)
    # can be improved (speed): 
    return [s for s in stage_array if isa(s,Stage{life_stage})][1] 
end
   

function get_stage(node::Node, life_stage::Type)
    # this can also be improved (speed): 
    stage_array = get_allstages(node)          
    return get_stage(stage_array, life_stage)
                
end 

############## For duration 
#= changing thinking about duration to be 1/duration -> total time in each SUB stage rather than stage. 
function get_duration(node::Node)
    return get_duration.(get_allstages(node))  # All stages in node 
end
=#
############## For substages  

function get_substages(node::Node)
    return get_substages.(get_allstages(node))  # All stages in node 
end


############## For density 

function get_density(node::Node)
    return get_density.(get_allstages(node))  # All stages in node 
end


function get_density(node::Node, life_stage::Type)
    stage_array = get_allstages(node)
    return get_stage(stage_array, life_stage).density  # Specific stage in node           
end  

############## For mortality 

function get_mortality(node::Node, life_stage::Type)
    stage_array = get_allstages(node)
    return get_stage(stage_array, life_stage).μ  # Specific stage in node           
end 

############## For genetics 

get_genetics(node::Node) = node.gene_data

get_drives(node::Node) = node.gene_data.all_genotypes

get_genotype(drive::Drive) = drive.genotype

function get_allgenotypes(node::Node)
    return get_genotype.(get_drives(node))
end
