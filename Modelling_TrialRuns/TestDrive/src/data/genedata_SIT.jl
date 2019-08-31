"""
This genetic data applies to an SIT scenario. It employs the Mendelian cube with modifications to the Tau parameter. Changes to Tau are made according to whether SIT is homozygous or not - namely, whether it is X- or Y-linked versus autosomal, and whether it is recessive or dominant.

All genedata_* files define the probability of a given genotype given two specified parental genotypes, build genotype-specific drives, and assemble the drives into a population-specific genetic profile. 

TODO: Verify!
"""


## SIT-specific structs 
struct AA <: Genotype end 
struct Aa <: Genotype end 
struct aa <: Genotype end 


## Cube slices 
sit1 = [1.0 0.50  0.0; 0.5 0.25  0.0; 0.0 0.00  0.0]

sit2 = [0.0 0.5 1.0; 0.5 0.5 0.5; 1.0 0.5 0.0]

sit3 = [0.0 0.00 0.0; 0.0 0.25 0.5; 0.0 0.50 1.0]


## Build drives: Drive(genotype, cube_slice, s, τ, ϕ, β, η)
drives_sit = [
    Drive(AA, sit1, 1.0, zeros(3,3), 0.5, 16.0, 1.0),      # tau = 0.0 assumes 100% effectiveness -> anyone with sterilized father won't be born 
    Drive(Aa, sit2, 1.0, ones(3,3), 0.5, 16.0, 1.0),       # to see if there are heterozygotes (there shouldn't be)
    Drive(aa, sit3, 1.0, ones(3,3), 0.5, 16.0, 1.0),  
]


## Put all genetic data together 
genetics_sit = Genetics(drives_sit)


## Data source: https://github.com/Chipdelmal/MGDrivE/blob/master/MGDrivE/R/Cube-SMendelian.R