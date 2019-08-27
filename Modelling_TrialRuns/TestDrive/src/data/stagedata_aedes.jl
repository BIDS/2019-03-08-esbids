"""
Stage information for specific pest (Aedes Aegypti). This can be used as-is to conduct experiments, or user can specify new data that defines different pests. 


TODO: 
(1) Is it better to always store stages in a dict with integer keys so I know where they are (this way, never out of order, eggs always 1 and males always 4 even if all juveniles removed)? See commented out example.
(2) Create climate-affected stages!! *** FOCUS HERE: TALL ORDER ***
(3) Create additional examples of known insect stages (eg, anopheles)
(4) Double check values for aedes stages with latest papers 
"""

# Aedes-specific stages
stages_aedes = [
    Stage(Egg, (1/4), 4, 0.05, dens_none, 0),    
    Stage(Larvae, (1/3), 8, 0.15, dens_log, 0),  
    Stage(Pupae, (1/6), 6, 0.05, dens_none, 0),  
    Stage(Male, nothing, 1, 0.09, dens_none, 0),  
    Stage(Female, nothing, 1, 0.09, dens_none, 500) # how to make substage for F take gN instead of zero? this number differs according to genetic approach (SIT, MCR, etc) rather than according to species -> heredity allowed somehow, since genetics always defined first? 
    ]


#= OLD: STAGES USING DICTS => BETTER? USE THIS INSTEAD?

stages_aedes = Dict{Int64, Stage}(1 => Stage(Egg, 4, (1/4), 4, 0.5, no_dens, 0),
                                 2 => Stage(Larvae, 3, (1/3), 8, 0.15, log_dens, 0), 
                                 3 => Stage(Pupae, 6, (1/6), 6, 0.05, no_dens, 0),
                                 4 => Stage(Male, nothing, nothing, 1, 0.09, no_dens, 0),
                                 5 => Stage(Female, nothing, nothing, nothing, 0.09, no_dens, 500),
)
=#