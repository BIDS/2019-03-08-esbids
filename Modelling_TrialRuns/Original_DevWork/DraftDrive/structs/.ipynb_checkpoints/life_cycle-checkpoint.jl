abstract type LifeStage end

struct Egg <: LifeStage end
struct Larvae <: LifeStage end
struct Pupae <: LifeStage end
struct MaleAdult <: LifeStage end
struct FemaleAdult <: LifeStage end

struct LifeCycle{S <: LifeStage}
	stage::Type{S}     # Stage descriptor
	T::Int64     # Total stage duration 
	n::Int64     # Number of "bins"/substages in this stage 
	μ::Float64   # Mortality aka probability of dying in this stage 
	γ::Union{Nothing,Float64}   # Density Dependet survival linear case
	K::Union{Nothing,Float64}   # Density Dependet survival logistic case
end