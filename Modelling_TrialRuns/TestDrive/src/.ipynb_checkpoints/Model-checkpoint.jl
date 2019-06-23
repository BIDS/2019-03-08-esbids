# This file has the function that gets feed into DIffeq and NLsolve

function init(du, u, params, t)
    
    ##################
    # State space
    ##################
    
    # Eggs 
    E = u[1:4,:]
    dE = @view du[1:4,:]
    
    # Larvae
    L = u[5:12,:]
    dL = @view du[5:12,:]

    # Pupae
    P = u[13:18,:]
    dP = @view du[13:18,:]
    
    # Check get data
    pupae = stages_dict[2]
    
    ##################
    # Params 
    ##################
    
    gN, ϕ, β, s, τ, cube, η, K, γ = params 
    
    ##################
    # Life functions 
    ##################
    
    # Eggs
    # dE = function_eggs(curr_state::Array, prev_state::Float64, (eggsnew, eggs))
    dE = function_eggs(data::Tuple) 
    
    # Larvae 
    # dL = function_larvae(curr_state::Array, prev_state::Array, (eggs, larvae)) 
    dL = function_larvae(data::Tuple)
    
    # Pupae 
    # dP = function_pupae(curr_state::Array, prev_state::Array, (larvae, pupae)) 
    dP = function_pupae(data::Tuple)


end 
