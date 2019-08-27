# "Main" file: Import/include necessary elements for package 

import Base.length      # To be able to apply "length" in structs/genestructs.jl  
import DiffEqBase       # To save time rather than importing all of DiffEq
import OrdinaryDiffEq   # Solvers: Just for now. Later, include in Example file. 
import Sundials         # Solvers: Just for now. Later, include in Example file.
import DiffEqCallbacks 
import Random
import NLsolve
import LinearAlgebra
#import Plots            # Plots: just for now. Later, play with use of Makie.jl and include in Example file. 


# To simplify calling these repeatedly 
const diffeq = DiffEqBase
const diffeqCB = DiffEqCallbacks

Random.seed!(123)

include("structs/envirostructs.jl")
include("structs/orgstructs.jl")    # TODO: Add new organism types for multiple dispatch
include("structs/lifestructs.jl")
include("structs/genestructs.jl")
include("structs/networkstructs.jl")

include("functions/envirofun.jl")
include("functions/lifefun.jl")
#include("functions/genefun.jl")    # re-create when needed 
#include("functions/networkfun.jl") # re-create when needed 

include("data/tempdata.jl")
include("data/densitydata.jl")
include("data/genedata_MCR.jl") 
include("data/genedata_RIDL.jl")
include("data/genedata_Mendelian.jl")
include("data/genedata_SIT.jl")
include("data/migratedata.jl")      # TODO: Include realistic migration matrices 
include("data/stagedata_aedes.jl")  # TODO: Include additional stagedata_* files for different insects   

include("utils/init.jl")   # TODO: Compute for alternative insects (might mean different stages) 
include("utils/popequations.jl")    # TODO: Compute for alternative insects (might mean different stages)
include("utils/callbacks.jl")       # TODO: Implement in a cleaner way. 

include("ModelNode.jl")
include("ModelNetwork.jl")