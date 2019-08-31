###########################
# Necessary packages
###########################

using DifferentialEquations
using AxisArrays
#using Plots
#gr()

###########################
# Base structs 
###########################
include("structs/life_cycle.jl")
include("structs/genotype.jl")
include("structs/populationtype.jl")


###########################
# Models 
###########################



###########################
# Utilities 
###########################
#include("utils/initializer.jl")



###########################
# Data 
###########################
include("data/parameters.jl");