"""
Create an independent function to compute each stage, preserving ultimate flexibility. Allows application to different insect types - only stages desired will be called into Diffeq to calculate population dynamics. 


Questions: 
(1) Include gN in parameters, else include as own argument? If latter, => gN::Int64
(2) Density dependence inclusion as K or as generic parameter -> also how to include in whatever state desired?
(3) How to effectively handle non-state functions (ovipos + mating) esp. those that require multiple prev_state (mating)
(4) How to modify dE, dL, etc "in place" later using @view?
(5) Valid = different approaches to u versus du?


NB: tuples can be any dimensions: (a,b,c)[3] -> use these to keep all function arguments generic ("Tuple" = 3 = prev, curr, params)

"""


## EGG: [gN, eggsnew, prev_q, prev_n, curr_μ, curr_q, curr_n]
function function_eggs(data::Tuple) 
    
    #prev = data[1]
    curr = data[1]
    params = data[2] # -> just gN, maybe also eggs_new since that's not a stage proper?
     
    dE = Array{Float64}(undef, curr.n, params.gN)
    
    
    for gene_index in 1:params.gN
        
        dE[1,gene_index] = params.eggsnew - curr.stage[1,gene_index]*(curr.μ + curr.q * curr.n) 
        
            for i in 2:size(dE)[1]  
            
               dE[i,gene_index] = curr.q * curr.n * curr.stage[i-1,gene_index] - curr.stage[i,gene_index] * 
            (curr.μ + curr.q * curr.n)
            
            end
        
    end
    
    return dE
end


## LARVAE: [K, gN, prev_q, prev_n, curr_μ, curr_q, curr_n]
function function_larvae(data::Tuple) 
    
    prev = data[1]
    curr = data[2]
    params = data[3]
    
    # dL = @view du[1:4,:]
    dL = Array{Float64}(undef, curr.n, params.gN)
    
    for gene_index in 1:params.gN
        
        dL[1,gene_index] = prev.q * prev.n * prev.stage[end,j] - curr.stage[1,j] * 
        (curr.μ *(1 + (sum(curr.stage)/K)) + curr.q * curr.n)
            
            for i in 2:size(dL)[1]
            
                dL[i,gene_index] = curr.q * curr.n * curr.stage[i-1,j] - curr.stage[i,j] * 
            (curr.μ *(1 + (sum(curr.stage)/K)) + curr.q * curr.n)
            
            end
    end
    
    return dL
    
end


## PUPAE:  [gN, prev_q, prev_n, curr_μ, curr_q, curr_n]
function function_pupae(data::Tuple) 
    
    prev = data[1]
    curr = data[2]
    params = data[3]
    
    # QUESTION: how to get around memory allocation AND easily use loops?
    # what about: dP = @view du[5:12,:]
    dP = Array{Float64}(undef, curr.n, params.gN)
    
    for gene_index in 1:params.gN
        
        dP[1,gene_index] = prev.q * prev.n * prev.stage[end, gene_index] - curr.stage[1,gene_index] *
         (curr.μ + curr.q * curr.n)
        
            for i in 2:size(dP)[1]
            
                dP[i,gene_index] = curr.q * curr.n * curr.stage[i-1,gene_index] - curr.stage[i,gene_index] * 
            (curr.μ + curr.q * curr.n)
            
            end
    end
    
    return dP
    
end



