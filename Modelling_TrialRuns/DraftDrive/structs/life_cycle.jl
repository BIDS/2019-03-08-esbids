###########################
# Declare applicable abstract type    
###########################
abstract type LifeStage end

###########################
# Setup one struct per life stage     
###########################
struct Egg <: LifeStage end
struct Larvae <: LifeStage end
struct Pupae <: LifeStage end
struct MaleAdult <: LifeStage end
struct FemaleAdult <: LifeStage end

###########################
# Define    
###########################
struct LifeParameters{S <: LifeStage}
	stage::Type{S} # Stage descriptor
	T::Int64       # Total stage duration 
	n::Int64       # Number of "bins"/substages in this stage 
	μ::Float64     # Mortality aka probability of dying in this stage 
	γ::Union{Nothing,Float64}   # Density dependent survival (larvae): LINEAR 
	K::Union{Nothing,Float64}   # Density dependent survival (larvae): LOGISTIC  
end