"""
Creates an independent function to compute each stage, preserving ultimate flexibility. Enables application of package to different insect types. 

TODO: 
(1) Density dependence: include in all states 
(2) Include insect-specific argument. Eg: organism::Mosquito
(3) Arguments -> how to standardize for all stages (important or not? same applies to init functions)
(4) Include temperature function in oviposition (and/or eggsnew) somehow? 
"""


## OVIPOSITION: 
function oviposit(F, cube, Τ, S, Β, gene_index::Int64)
    return  sum(cube[:,:,gene_index].*Τ[:,:,gene_index].*S[gene_index]*Β[gene_index].*F)
end


## EGG: 
function create_egg!(dE, E, node::Node, eggsnew, gene_index::Int64, ctemp) 
    
    # Additional lifestage elements 
    dens = compute_density(get_density(node, Egg), E)
    
    curr = get_stage(node, Egg)
    curr_q = tempeffect_E(ctemp, curr.μ, curr.q)[2]  
    curr_μ = tempeffect_E(ctemp, curr.μ, curr.q)[1]
    
    prev = eggsnew
    
    # Loop through genotypes 
    dE[1,gene_index] = prev - E[1,gene_index]*(curr_μ * dens + curr_q * curr.n) 
        
        for i in 2:size(dE)[1]  
            
            dE[i,gene_index] = curr_q * curr.n * E[i-1,gene_index] - E[i,gene_index] * (curr_μ * dens + curr_q * curr.n) # dens here is essentially dividing a state so may present issues with decision model -> write it up on paper to ensure correct 
            
        end
  
    # Update matrix
    
    return 
    
end



## LARVAE: 
function create_larvae!(dL, L, E, node::Node, gene_index::Int64, ctemp) 
    
    # Additional lifestage elements
    dens = compute_density(get_density(node, Larvae), L)
    
    curr = get_stage(node, Larvae)
    curr_q = tempeffect_L(ctemp, curr.μ, curr.q)[2]  
    curr_μ = tempeffect_L(ctemp, curr.μ, curr.q)[1]
    
    prev = get_stage(node, Egg)
    prev_q = tempeffect_E(ctemp, prev.μ, prev.q)[2]  
    
    # Loop through genotypes 
    dL[1,gene_index] = prev_q * prev.n * E[end,gene_index] - L[1,gene_index] * (curr_μ * dens + curr_q * curr.n)
            
        for i in 2:size(dL)[1]
            
            dL[i,gene_index] = curr_q * curr.n * L[i-1,gene_index] - L[i,gene_index] * (curr_μ * dens + curr_q * curr.n) # change name  to compute dens, something 
            
        end

    #= ORIGINAL  (without density struct)
    dL[1,gene_index] = prev.q * prev.n * E[end,gene_index] - L[1,gene_index] * (curr.μ *(1 + (sum(L)/k)) + curr.q * curr.n)
            
        for i in 2:size(dL)[1]
            
            dL[i,gene_index] = curr.q * curr.n * L[i-1,gene_index] - L[i,gene_index] * (curr.μ *(1 + (sum(L)/k)) + curr.q * curr.n)
            
        end
    =#
    
    # Update matrix 
    return 
    
end


## PUPAE:  
function create_pupae!(dP, P, L, node::Node, gene_index::Int64, ctemp) 
 
    # Additional lifestage elements
    dens = compute_density(get_density(node, Pupae), P)
    
    curr = get_stage(node, Pupae)
    curr_q = tempeffect_P(ctemp, curr.μ, curr.q)[2]  
    curr_μ = tempeffect_P(ctemp, curr.μ, curr.q)[1]
    
    prev = get_stage(node, Larvae)
    prev_q = tempeffect_L(ctemp, prev.μ, prev.q)[2]  
    
    # Loop through genes 
    dP[1,gene_index] = prev_q * prev.n * L[end, gene_index] - P[1,gene_index] *
         (curr_μ * dens + curr_q * curr.n)
        
        for i in 2:size(dP)[1]
            
            dP[i,gene_index] = curr_q * curr.n * P[i-1,gene_index] - P[i,gene_index] * 
            (curr_μ * dens + curr_q * curr.n)
            
        end

    # Update matrix 
    return 
    
end


## MALES 
function create_male!(dM, M, P, Φ, node::Node, controls, gene_index::Int64, ctemp) 

    # Additional lifestage elements
    dens = compute_density(get_density(node, Male), M)
    
    curr = get_stage(node, Male)
    curr_μ = tempeffect_A(ctemp, curr.μ)
    
    prev = get_stage(node, Pupae)
    prev_q = tempeffect_P(ctemp, prev.μ, prev.q)[2] 
    
    # Loop through genes 
    if gene_index == 1
        dM[gene_index] = (1-Φ[gene_index])* prev_q * prev.n * P[end,gene_index] - curr_μ * M[gene_index] * dens + controls[1] # Recall: controls index 1 = males, 2 = females, etc.
            
    else        
            dM[gene_index] = (1-Φ[gene_index]) * prev_q * prev.n * P[end,gene_index] - curr_μ * M[gene_index] * dens
                
    end
    
    # Update matrix 
    return 
        
end
    
## MATING: 
function mate(P, M, Φ, Η, node::Node, gene_index::Int64, ctemp) 

    # Additional lifestage elements
    prev = get_stage(node, Pupae) 
    prev_q = tempeffect_P(ctemp, prev.μ, prev.q)[2] 
    
    # Loop through genotypes 
    nowmate = M.*Η
    nowmate = LinearAlgebra.normalize(nowmate)  # normalizing is dividing by the two-norm and therefore can be reformulated (and is defined as convex)

    return nowmate*(Φ[gene_index] * prev_q * prev.n * P[end,:]')
    
end
    
## FEMALES 
function create_female!(dF, F, node::Node, matematrix::Array, gene_index::Int64, ctemp) 
    
    # Additional lifestage elements 
    dens = compute_density(get_density(node, Female), F)
        
    curr = get_stage(node, Female)
    curr_μ = tempeffect_A(ctemp, curr.μ)
    
    # Loop through genotypes and also female types
    for eachF in 1:size(dF)[1]   
        
            dF[eachF,gene_index] = matematrix[eachF,gene_index] - curr_μ * F[eachF,gene_index] * dens
      
    end
    
    # Update matrix 
    return 

end
    
