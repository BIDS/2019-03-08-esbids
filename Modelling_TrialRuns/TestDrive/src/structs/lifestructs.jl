"""
Includes Stage and Density 

Question: Location/order of model-specific structs correct?
Question: get_density correct/better way? 
Question: include any get_stage getter functions here?
"""


## Stage
abstract type LifeStage end 

struct Stage{L <: LifeStage}
    stage::Type{L}                     # Stage type
    t::Union{Nothing, Float64}         # Total stage duration
    q::Union{Nothing, Float64}         # 1/duration = total time in each substage 
    n::Union{Nothing, Int64}           # Number of substages 
    μ::Float64                         # Mortality 
    d::Any                             # Flexible density dependence specification 
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
    model::Type{D}                  # Currently available: logistic or linear (can be expanded)
    param::Float64                  # K in case of logistic, γ in case of linear
end

struct Linear <: DensityModel end
struct Logistic <: DensityModel end





## Get/access functions
get_density(stage::Stage) = stage.d