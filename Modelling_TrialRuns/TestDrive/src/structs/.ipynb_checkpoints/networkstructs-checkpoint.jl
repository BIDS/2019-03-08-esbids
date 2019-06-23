"""
Includes Node and Network 

Question: Node.all_stages::Vector{Stage}  *OR*  Node.all_stages::Dict{Int64, Stage}  ??
"""

## Node
struct Node 
    name::Symbol                     # Name of node (eg, neighborhood)
    gene_data::Genetics              # Genetic information for entire population in node
    all_stages::Dict{Int64,Stage}        # OR Dict{Int64, Stage} ? Array of all stages present in node
    location::Tuple{Float64,Float64} # Coordinates of geographic location 
    migration::Array{Float64,3}      # Tensor with each slice applicable to one state's movement  
end


## Network 
struct Network
    
    all_nodes::Vector{Node}
    all_locations::Vector{Tuple{Float64, Float64}}                      
    net_migration::Array{Float64,4}  # Need one matrix per "state" (genotype x stage pair) -> 
                                     # therefore one cube per node (migration for all states) ->
                                     # therefore must add a fourth dimension to encompass network 
    
    function Network(all_nodes::Vector{Node}, n_states::Int64)   
        
        n_nodes = length(all_nodes)
        all_locations = Vector{Tuple{Float64,Float64}}(undef, n_nodes)     
        net_migration = Array{Float64,4}(undef, n_nodes, n_states, n_nodes, n_nodes) 
        
        for (index, n) in enumerate(all_nodes) 
            all_locations[index] = n.location
            net_migration[index, :, :, :] = n.migration # returns a 3x3 tensor specific to each node 
        end
        
        new(all_nodes, all_locations, net_migration) 
        
    end
    
end

## Get/access functions 
get_genetics(node::Node) = node.gene_data
get_allstages(node::Node) = node.all_stages

function get_stage(stage_array::Vector{Stage}, life_stage::Type)
    
    # can be improved (speed): 
    return [s for s in stage_array if isa(s,Stage{life_stage})][1] # isa = way of getting content of array by time 

end
            
function get_stage(node::Node, life_stage::Type)
    
    # this can also be improved 
    stage_array = get_allstages(node)
                
    return get_stage(stage_array, life_stage)
                
end  