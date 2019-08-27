"""
The determinisitc population equation applicable to NETWORK objects that is used to feed into (1) NLSolve and (2) DiffEq calculations. 

TODO: 
(1) Is there a way to combine the netowk and node model.jl files? should there be - does it matter? 
"""

# Population equation: 
function population_model_network(du, u, (network, controls), t) 
    
    # create empty migration matrix of size u0 * number of nodes
    # migrationflowsmatrix = []
        
    ##################
    # Network 
    ##################
    
    #for node in network.all_nodes
    for (index,n) in enumerate(network.all_nodes)
    
    ##################
    # Parameters 
    ##################
    
    # Genetic elements 
    genetics = get_genetics(network.all_nodes[index])
    gN = length(genetics.all_genotypes)
    cube = genetics.cube
    S = genetics.S
    Τ = genetics.Τ
    Β = genetics.Β
    Φ = genetics.Φ
    Η = genetics.Η
    
    # Lifestage elements 
    n = get_substages(network.all_nodes[index])
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
    E = u[1:nE, :, index]  
    dE = @view du[1:nE, :, index]
    
    # Larvae
    L = u[1+nE : nE+nL, :, index]
    dL = @view du[1+nE : nE+nL, :, index]

    # Pupae
    P = u[1+nE+nL : nE+nL+nP, :, index]
    dP = @view du[1+nE+nL : nE+nL+nP, :, index]
    
    # Males 
    M = u[1+nJuv, :, index]
    dM = @view du[1+nJuv, :, index]
    
    # Females 
    F = u[1+nM+nJuv : nF, :, index]
    dF = @view du[1+nM+nJuv : nF, :, index]

    ##################
    # Lifestage functions  
    ##################

    # Loop through genotypes
    for gene_index in 1:gN
        
        # Oviposit
        eggsnew = oviposit(F, cube, Τ, S, Β, gene_index) # investigate ctemp inclusion 
        
        # Egg
        create_egg!(dE, E, network.all_nodes[index], eggsnew, gene_index, ctemp) # ctemp = celsius temperature 

        # Larvae
        create_larvae!(dL, L, E, network.all_nodes[index], gene_index, ctemp) 
    
        # Pupae
        create_pupae!(dP, P, L, network.all_nodes[index], gene_index, ctemp) 
    
        # Males
        create_male!(dM, M, P, Φ, network.all_nodes[index], controls, gene_index, ctemp)
    
        # Mate
        matematrix = mate(P, M, Φ, Η, network.all_nodes[index], gene_index, ctemp) # must include ctemp for pupae
    
        # Females 
        create_female!(dF, F, network.all_nodes[index], matematrix, gene_index, ctemp) 
        
    end # Genotype loop 
        
end # Nodal loop 
    
end # DiffEq function 
