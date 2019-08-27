###########################
# Declare applicable abstract type    
###########################
abstract type Genotype end

###########################
# Setup one struct per genotype  
###########################
struct HH <: Genotype end 
struct Hh <: Genotype end 
struct HR <: Genotype end
struct hh <: Genotype end 
struct hR <: Genotype end 
struct RR <: Genotype end

###########################
# Define life stages according to genotype:
# Genes will inform life stage length, fertility, mortality, etc. 
###########################
struct GenesDefineLife{G <: Genotype}
	genotype::Type{G}
##################################################### QUESTION IS THIS ACTUALLY IH? HOW INTERACT WITH *REAL* CUBE? 
	cube_layer::AxisArray
	life_cycle::Vector{LifeParameters{<:LifeStage}}
end

