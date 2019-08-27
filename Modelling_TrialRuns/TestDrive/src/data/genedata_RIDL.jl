"""
This genetic data applies to a RIDL scenario.

All genedata_* files define the probability of a given genotype given two specified parental genotypes, build genotype-specific drives, and assemble the drives into a population-specific genetic profile. 

TODO: Verify values non-ih cube elements (tau, beta, eta, etc); discuss difference between RIDL and Mendelian (note offspring probabilities are the same); confirm correct release number and timing used in MGDrivE experiments. 

FS (female-specific): Set pupae females to zero = squiggle thing = xi_F = 0 in the WR and RR if drive is dominant and just RR if not because females dont pupate and males can. in reglar ridle niether of them pupate - FS is more effective because males can still mate and drag things a bit longer)
"""

## RIDL-specific structs (Release of Insects with Dominant Lethality)
struct WW <: Genotype end # wildtype
struct WR <: Genotype end 
struct RR <: Genotype end 

## Cube slices 
ridl1 = [1.0 0.5  0.0; 0.5 0.25  0.0; 0.0 0.0  0.0]

ridl2 = [0.0 0.5 1.0; 0.5 0.5 0.5; 1.0 0.5 0.0]

ridl3 = [0.0 0.0 0.0;  0.0 0.25 0.5; 0.0 0.50 1.0]


## Build drives: Drive(genotype, cube_slice, s, τ, ϕ, β, η)
drives_ridl = [
    Drive(WW, ridl1, 1.0, ones(3,3), 0.5, 16.0, 1.0),  
    Drive(WR, ridl2, 1.0, ones(3,3), 0.5, 16.0, 1.0), 
    Drive(RR, ridl3, 1.0, ones(3,3), 0.5, 16.0, 1.0),      
]

## Put all genetic data together 
genetics_ridl = Genetics(drives_ridl)

## Data source: https://github.com/Chipdelmal/MGDrivE/blob/master/MGDrivE/R/Cube-RIDL.R

