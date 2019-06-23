"""
This genetic data applies to simple MCR:
- Create genotype-specific layers
- Build genotype-specific drives 
- Assemble all into the genetics specific to this population 

"""

## Cube slices 
slice1 = [1.0 1.0 0.50  0  0  0; 1.0 1.0 0.50  0  0  0; 0.5 0.5 0.25  0  0  0; 
        0.0 0.0 0.00  0  0  0; 0.0 0.0 0.00  0  0  0; 0.0 0.0 0.00  0  0  0]

slice2 = [0.0 0.0 0.00 1.0 0.50  0; 0.0 0.0 0.00 1.0 0.50  0; 0.0 0.0 0.00 0.5 0.25  0; 
        1.0 1.0 0.50 0.0 0.00  0; 0.5 0.5 0.25 0.0 0.00  0; 0.0 0.0 0.00 0.0 0.00  0]

slice3 = [0.0 0.0 0.50  0 0.50 1.0; 0.0 0.0 0.50  0 0.50 1.0; 0.5 0.5 0.50  0 0.25 0.5;
        0.0 0.0 0.00  0 0.00 0.0; 0.5 0.5 0.25  0 0.00 0.0; 1.0 1.0 0.50  0 0.00 0.0]

slice4 = [0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 
        0  0  0 1.0 0.50  0; 0  0  0 0.5 0.25  0; 0  0  0 0.0 0.00  0]

slice5 = [0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 0  0 0.00 0.5 0.25 0.0; 
        0  0 0.50 0.0 0.50 1.0; 0  0 0.25 0.5 0.50 0.5; 0  0 0.00 1.0 0.50 0.0]

slice6 = [0  0  0 0.0 0.00  0; 0  0  0 0.0 0.00  0; 0  0 0.25  0 0.25 0.5; 
        0  0 0.00  0 0.00 0.0; 0  0 0.25  0 0.25 0.5; 0  0 0.50  0 0.50 1.0]


## Build drives: Drive(genotype, cube_slice, s, τ, ϕ, β, η)
drives = [
    Drive(HH, slice1, 1.0, ones(6,6), 0.5, 16.0, 1.0),
    Drive(Hh, slice2, 1.0, ones(6,6), 0.5, 16.0, 1.0), 
    Drive(HR, slice3, 1.0, ones(6,6), 0.5, 16.0, 1.0),
    Drive(hh, slice4, 1.0, ones(6,6), 0.5, 16.0, 1.0),
    Drive(hR, slice5, 1.0, ones(6,6), 0.5, 16.0, 1.0),
    Drive(RR, slice6, 1.0, ones(6,6), 0.5, 16.0, 1.0)    
]


## Put all genetic data together 
genetics = Genetics(drives)