using DifferentialEquations
using AxisArrays
#using Plots
#gr()

## Base Structs
include("structs/life_cycle.jl")
include("structs/genotype.jl")
include("structs/population.jl")

## Models


## Utilities
#include("utils/initializer.jl")

## Data For modeling
include("data/MGDrive_parameters.jl");