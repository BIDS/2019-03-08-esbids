"""
Density functions 
"""

# Linear density 
function compute_density(data::Density{LinearDens}, stage) 
    return data.param * sum(stage)        # This equation may not be correct; check against Hancock.
end



# Logistic density 
function compute_density(data::Density{LogisticDens}, stage)
    return (1 + (sum(stage)/data.param))  # This equation is checked against MGDrivE -> NB for decision model that nonlinearity not an issue bc sum is divided by a single parameter 
end


# No density 
function compute_density(data::Density{NoDens}, stage)
    return data.param                               
end
