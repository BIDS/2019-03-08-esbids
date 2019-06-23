
"""

The population equation that is used to feed into (1) NLSolve and (2) DiffEq

Call stagecalc.jl functions as desired into DiffEq function to compute dynamics of the population as a whole; flexible structure enables portrayal of insects with different life stages.  

NB: Use u0 calculated in eqcalc.jl to begin with appropriate equilibrium population levels. 

Question: This isn't finished yet. Needs to include control setup/callback/problem creation/"sol". Should Callbacks go in a separate file and everything be solved in yet another file? 

Question: (Related to above) Should the same function be used for both NLSolve and DiffEq (becasue they are the same) but then solved in two different locations? 

Questionssss: In either case (referencing both q's above) what should the arguments to diffeq fucntion be - same? Don't they need to be in a huge matrix and therefore that needs to be created first then fed in? If so should there be a separate file to create it and then this one would call it - that way the only thing modified by the user would be that created matrix? Does each node run through DiffEq separately? 

"""
function population_model(du, u, params, t)
    
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
    # Parameters 
    ##################
    
    gN, ϕ, β, s, τ, cube, η, K, γ = parameters 
    
    ##################
    # Functions  
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
