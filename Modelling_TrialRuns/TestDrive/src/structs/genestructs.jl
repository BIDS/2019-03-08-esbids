"""
Includes Drive and Genetics.

TODO: 
(1) Test on constructs beyond MCR (eg, Mendelian and SplitDrive). 
"""

## Drive: one genotype at a time (subsets Genetics)
abstract type Genotype end

struct Drive{G <: Genotype} 
    genotype::Type{G}            # single genotype 
    cube_slice::Array{Float64,2} # offspring likelihoods for this genotype     
    s::Float64                   # fractional reduction in fertility
    τ::Array{Float64,2}          # offspring viability
    ϕ::Float64                   # male to female emergence ratio (gender)
    β::Float64                   # female fecundity
    η::Float64                   # male mating fitness
end

## Genetics: All genotype-specific aspects, including Reproduction parameters 
struct Genetics 
    
    all_genotypes::Array{Drive{<:Genotype}}  # all genotypes in this population 
    cube::Array{Float64, 3}                  # offspring likelihoods, per genotype
    S::Vector{Float64}                       # fractional reduction in fertility, per genotype - masks the number of eggs (scales)
    Τ::Array{Float64,3}                      # offspring viability, per genotype  
    Φ::Vector{Float64}                       # male to female emergence ratio (gender), per genotype 
    Β::Vector{Float64}                       # female fecundity, per genotype  - normal average egg number for all females (23 for aedes)
    Η::Vector{Float64}                       # male mating fitness, per genotype 
        
        function Genetics(all_genotypes::Array{Drive{<:Genotype}}) 
            
            gN = length(all_genotypes)       # number of different genes being considered 
            cube = Array{Float64, 3}(undef, gN, gN, gN)            
            S = Vector{Float64}(undef, gN)
            Τ = Array{Float64,3}(undef, gN, gN, gN)
            Φ = Vector{Float64}(undef, gN)
            Β = Vector{Float64}(undef, gN)
            Η = Vector{Float64}(undef, gN)
        
            for (index, g) in enumerate(all_genotypes)
                cube[:,:,index] = g.cube_slice # depth slice = distribution of offspring, 
                S[index] = g.s                 # horiz slice = XX offspring for all parental combos
                Τ[:,:,index] = g.τ
                Φ[index] = g.ϕ
                Β[index] = g.β
                Η[index] = g.η
            end
            
            new(all_genotypes, cube, S, Τ, Φ, Β, Η)
        
        end
    
end

## Methods for this struct include: 
length(G::Genetics) = length(G.all_genotypes)  # Be sure to: `import Base.length` in Main.jl


## See individual genedata_* files for construct-specific structs 








