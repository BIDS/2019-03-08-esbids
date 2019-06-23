"""
Functions for Stage and Density 

Question: correct to include lin_dens and log_dens here?
Question: correct to include functions building MCR-specific here, or should that remain in data section? 
"""


## Density

# Linear 
function density_model(data::Density{Linear}, stage::Stage)
    
    return data.param * stage  
    
end

lin_dens = Density(Linear, 5.0)


# Logistic 
function density_model(data::Density{Logistic}, Lifeststage::Stage)
    
    return (1 + (sum(stage)/data.param))
    
end

log_dens = Density(Logistic, 9.0)