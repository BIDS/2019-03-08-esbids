"""
Includes Stage and Density. 

TODO: 
(1) How to further improve density implementation/develop better functional forms?
(2) How to include climactic concerns (temp, precip) in both stage AND density? 

NB from David re: use of structs vs. mutable structs" 
Could interpret as initial values -> in which case use just struct. Or interpret it as a structure that holds the current values, changing as you simulate -> use mutable struct. 
"""

## Density 

abstract type DensityDependence end

struct Density{D <: DensityDependence}
    model::Type{D}                  # Currently available: logistic, linear, or none
    param::Float64                  # 355.0 in logistic, ?? in linear, 1.0 in none
end

struct LinearDens <: DensityDependence end
struct LogisticDens <: DensityDependence end
struct NoDens <: DensityDependence end 


## Stage

abstract type LifeStage end 

struct Stage{L <: LifeStage}
    stage::Type{L}                     # Stage type
    # duration::Union{Nothing, Int64}  # Total stage duration: necessary to have this AND q? 
    q::Union{Nothing, Float64}         # 1/duration = total time in each substage -> 1/total stage duration
    n::Union{Nothing, Int64}           # Number of substages 
    μ::Float64                         # Mortality 
    density::Density                   # Flexible density dependence model specification 
    N0::Int64                          # Initial count (Question: "any" or "int64"?) 
end


struct Egg <: LifeStage end
struct Larvae <: LifeStage end
struct Pupae <: LifeStage end
struct Male <: LifeStage end
struct Female <: LifeStage end



## Get/access functions

# get_duration(stage::Stage) = stage.q # changing thinking about duration to be 1/duration -> total time in each SUB stage rather than stage.

get_mortality(stage::Stage) = stage.μ # Specific stage, no node 

get_substages(stage::Stage) = stage.n # Specific stage, no node

get_density(stage::Stage) = stage.density # Specific stage, no node


