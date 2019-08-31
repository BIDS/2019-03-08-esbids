"""
This genetic data applies to simple MCR.

All genedata_* files define the probability of a given genotype given two specified parental genotypes, build genotype-specific drives, and assemble the drives into a population-specific genetic profile. 
"""

## MCR-specific structs 
struct HH <: Genotype end 
struct Hh <: Genotype end 
struct HR <: Genotype end
struct hh <: Genotype end 
struct hR <: Genotype end 
struct RR <: Genotype end


## Cube slices 
mcr1 = [1.0 1.0 0.50  0  0  0; 1.0 1.0 0.50  0  0  0; 0.5 0.5 0.25  0  0  0; 
        0.0 0.0 0.00  0  0  0; 0.0 0.0 0.00  0  0  0; 0.0 0.0 0.00  0  0  0]

mcr2 = [0.0 0.0 0.00 1.0 0.50  0; 0.0 0.0 0.00 1.0 0.50  0; 0.0 0.0 0.00 0.5 0.25  0; 
        1.0 1.0 0.50 0.0 0.00  0; 0.5 0.5 0.25 0.0 0.00  0; 0.0 0.0 0.00 0.0 0.00  0]

mcr3 = [0.0 0.0 0.50  0 0.50 1.0; 0.0 0.0 0.50  0 0.50 1.0; 0.5 0.5 0.50  0 0.25 0.5;
        0.0 0.0 0.00  0 0.00 0.0; 0.5 0.5 0.25  0 0.00 0.0; 1.0 1.0 0.50  0 0.00 0.0]

mcr4 = [0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 
        0  0  0 1.0 0.50  0; 0  0  0 0.5 0.25  0; 0  0  0 0.0 0.00  0]

mcr5 = [0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 0  0 0.00 0.5 0.25 0.0; 
        0  0 0.50 0.0 0.50 1.0; 0  0 0.25 0.5 0.50 0.5; 0  0 0.00 1.0 0.50 0.0]

mcr6 = [0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 0  0 0.25  0 0.25 0.5; 
        0  0 0.00  0 0.00 0.0; 0  0 0.25  0 0.25 0.5; 0  0 0.50  0 0.50 1.0]


## Build drives: Drive(genotype, cube_slice, s, τ, ϕ, β, η)
drives_mcr = [
    Drive(HH, mcr1, 1.0, ones(6,6), 0.5, 16.0, 1.0),   #ones(6,6)
    Drive(Hh, mcr2, 1.0, ones(6,6), 0.5, 16.0, 1.0), 
    Drive(HR, mcr3, 1.0, ones(6,6), 0.5, 16.0, 1.0),
    Drive(hh, mcr4, 1.0, ones(6,6), 0.5, 16.0, 1.0),
    Drive(hR, mcr5, 1.0, ones(6,6), 0.5, 16.0, 1.0),
    Drive(RR, mcr6, 1.0, ones(6,6), 0.5, 16.0, 1.0)    
]


## Put all genetic data together 
genetics_mcr = Genetics(drives_mcr)

## Source: find correct MGDRivE documentation! 