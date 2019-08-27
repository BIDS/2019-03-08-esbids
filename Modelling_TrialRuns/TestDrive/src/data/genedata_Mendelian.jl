"""
This genetic data applies to a Mendelian scenario.

All genedata_* files define the probability of a given genotype given two specified parental genotypes, build genotype-specific drives, and assemble the drives into a population-specific genetic profile. 

TODO: Verify values non-ih cube elements (tau, beta, eta, etc); discuss difference between Mendelian and RIDL (note offspring probabilities are the same); confirm correct release number and timing used in MGDrivE experiments. 
"""


## Mendelian-specific structs 
struct AA <: Genotype end 
struct Aa <: Genotype end 
struct aa <: Genotype end 


## Cube slices 
mend1 = [1.0 0.50  0.0; 0.5 0.25  0.0; 0.0 0.00  0.0]

mend2 = [0.0 0.5 1.0; 0.5 0.5 0.5; 1.0 0.5 0.0]

mend3 = [0.0 0.00 0.0; 0.0 0.25 0.5; 0.0 0.50 1.0]


## Build drives: Drive(genotype, cube_slice, s, τ, ϕ, β, η)
drives_mendelian = [
    Drive(AA, mend1, 1.0, ones(3,3), 0.5, 16.0, 1.0),
    Drive(Aa, mend2, 1.0, ones(3,3), 0.5, 16.0, 1.0), 
    Drive(aa, mend3, 1.0, ones(3,3), 0.5, 16.0, 1.0),  
]


## Put all genetic data together 
genetics_mendelian = Genetics(drives_mendelian)


## Data source: https://github.com/Chipdelmal/MGDrivE/blob/master/MGDrivE/R/Cube-SMendelian.R