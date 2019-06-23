"""
Includes Stage and Density 
"""


## Stage
abstract type LifeStage end 

struct Stage{L <: LifeStage}
    stage::Type{L}
    t::Union{Nothing, Float64}         # Total stage duration
    q::Union{Nothing, Float64}         # 1/duration = total time in each substage 
    n::Union{Nothing, Int64}           # Number of substages 
    μ::Float64                         # Mortality 
    d::Any    # Enables flexible density dependence specification 
    N0::Int64                          # Initial count (Question: "any" or "int64"?) 
end


struct Egg <: LifeStage end
struct Larvae <: LifeStage end
struct Pupae <: LifeStage end
struct Male <: LifeStage end
struct Female <: LifeStage end




## Density 
abstract type DensityModel end

struct Density{D <: DensityModel}
    model::Type{D}
    param::Float64  # K in case of logistic, γ in case of linear
end

struct Linear <: DensityModel end
struct Logistic <: DensityModel end





## Get/access functions
get_allstages(node::Node) = @view node.all_stages[:]

function get_stage(stage_array::Vector{Stage}, life_stage::Type)
    
    # can be improved (speed): 
    return [s for s in stage_array if isa(s,Stage{life_stage})][1] # isa = way of getting content of array by time 

end
            
function get_stage(node::Node, life_stage::Type)
    
    # this can also be improved 
    stage_array = get_allstages(node)
                
    return get_stage(stage_array, life_stage)
                
end  

get_density(stage::Stage) = stage.d