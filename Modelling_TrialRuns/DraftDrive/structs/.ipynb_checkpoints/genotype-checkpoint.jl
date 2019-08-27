abstract type Genotype end

struct HH <: Genotype end 
struct Hh <: Genotype end 
struct HR <: Genotype end
struct hh <: Genotype end 
struct hR <: Genotype end 
struct RR <: Genotype end

struct GeneSpecificLife{G <: Genotype}
	genotype::Type{G}
	cube_layer::AxisArray
	life_cycle::Vector{LifeCycle{<:LifeStage}}
end