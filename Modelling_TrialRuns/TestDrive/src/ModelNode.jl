"""
The determinisitc population equation applicable to NODE objects that is used to feed into (1) NLSolve and (2) DiffEq calculations. 

TODO: 
(1) How to move "eggsnew" function outside of the gene_index loop?
(2) How to make flexible to different stage functions (eg, insect with no larval, multiple pupal stages)?
(3) Implement stochasticity -> create different function for this? 
"""

# Population equation: 

function population_model_node(du, u, (node, controls), t)
         
    ##################
    # Parameters 
    ##################
    
    # Genetic elements 
    genetics = get_genetics(node)
    gN = length(genetics.all_genotypes)
    cube = genetics.cube
    S = genetics.S
    Τ = genetics.Τ
    Β = genetics.Β
    Φ = genetics.Φ
    Η = genetics.Η
    
    # Lifestage elements 
    n = get_substages(node) # change semantics: get_substage_count
    nE = n[1]
    nL = n[2]
    nP = n[3]
    nJuv = nE+nL+nP
    nM = n[4]
    nF = n[5]*gN + nM + nJuv
    
    # Temperature model 
    ctemp = temp_model(node.temperature, t)
    #@show (ctemp,t)
    
    ##################
    # State space
    ##################
    
    # Eggs 
    E = u[1:nE, :]  
    dE = @view du[1:nE, :]
    
    # Larvae
    L = u[1+nE : nE+nL, :]
    dL = @view du[1+nE : nE+nL, :]

    # Pupae
    P = u[1+nE+nL : nE+nL+nP, :]
    dP = @view du[1+nE+nL : nE+nL+nP, :]
    
    # Males 
    M = u[1+nJuv, :]
    dM = @view du[1+nJuv, :]
    
    # Females 
    F = u[1+nM+nJuv : nF, :]
    dF = @view du[1+nM+nJuv : nF, :]

    ##################
    # Lifestage functions  
    ##################

    # Loop through genotypes
    for gene_index in 1:gN
        
        # Oviposit
        eggsnew = oviposit(F, cube, Τ, S, Β, gene_index) # investigate ctemp inclusion 
        #@show(gene_index, eggsnew, Τ[:, :, gene_index])
        
        # Egg
        create_egg!(dE, E, node, eggsnew, gene_index, ctemp) # ctemp = celsius temperature 
        #@show(gene_index, eggsnew, E[:, gene_index])

        # Larvae
        create_larvae!(dL, L, E, node, gene_index, ctemp) 
    
        # Pupae
        create_pupae!(dP, P, L, node, gene_index, ctemp) 
    
        # Males
        create_male!(dM, M, P, Φ, node, controls, gene_index, ctemp)
        #@show(gene_index, M[gene_index], t)
    
        # Mate
        matematrix = mate(P, M, Φ, Η, node, gene_index, ctemp) # must include ctemp for pupae
        #@show(matematrix)
    
        # Females 
        create_female!(dF, F, node, matematrix, gene_index, ctemp) 
        #@show(gene_index, F)
        
    end # Genotype loop 
    
end # DiffEq function 
