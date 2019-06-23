#Import/include necessary elements for TestDrive package 
#Question: Not all pieces require a "function" file, so 2 of the 3 existing are empty. OK? 


import Base.length
import DifferentialEquations
import Random

const diffeq = DifferentialEquations

Random.seed!(123)

include("structs/lifestructs.jl")
include("structs/genestructs.jl")
include("structs/networkstructs.jl")

include("functions/lifefun.jl")
include("functions/genefun.jl")
include("functions/networkfun.jl")

include("data/genedata_MCR.jl") # Include additional genedata_* files for each different drive 
include("data/migratedata.jl")  # Potentially move to Example.jl file 
include("data/builddata.jl")    # Also potentially move to Example.jl file 

include("utils/initcalc.jl")    # Compute initial guesses for NLSolve
include("utils/eqcalc.jl")      # Apply NLSolve to find true equilibrium of each state (for wildtype/pre-existing pop)
include("utils/stagecalc.jl")   # Functions to calculate each population stage independently 
include("utils/popcalc.jl")     # Call stagecalc.jl functions independently to preserve flexibility of different insects

include("Model.jl")