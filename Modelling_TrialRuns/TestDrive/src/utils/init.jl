"""
Analytic calculations furnish "best guess" of equilibrium for each stage.
NB: Order must be preserved (pupae come first).

TODO: 
(1) Add insect-specific argument to all functions - use struct to do this. Eg: (node::Node, organism::Mosquito, lifestage::Type, gene_index::Int64)
(2) How to initiate more than one genotype at a time?
(3) How to avoid use of the additional arguments in L0, M0 calculation?
(4) Since all init_stages require similar get_genetics, etc, best to do this outside and wrap it all  (as with population_model)? Currently not done because right now able to choose whether initializing individual states versus whole node - is such flexibility necessary given that must have whole population matrix initialized in order to run NLSolve? 
(5) How to approach when no analytic guesses included - just use zeros to start (assumption: possible to do in this case bc model is not "too" non-linear)?
(6) Does density dependence need to factor into analytic guesses at all? NO, right? Because used in population_model equations. 

(7) temperature concerns for F(currently none in init) and oviposition (currently none in either but should consider including in popequations - in which concern re: lack in init would also apply here)

"""
# Question (for Sean): Why is μ for E and L stages not included in L calculation?

##############
# PUPAE
##############
# (NF, μF, nP, qP, ϕ, μP)


function init_pupae!(node::Node, gene_index::Int64, ctemp) 
    
    # Access necessary stages via Node 
    female = get_stage(node, Female)
    NF = female.N0
    μF = female.μ
    
    pupae = get_stage(node, Pupae)
    # P0_begin = pupae.N0
    nP = pupae.n
    #qP = pupae.q
    qP = tempeffect_P(ctemp, pupae.μ, pupae.q)[2] 
    #μP = pupae.μ
    μP = tempeffect_P(ctemp, pupae.μ, pupae.q)[1] 
    
    # Access necessary genetic info via Node
    genetics = get_genetics(node)
    gN = length(genetics.all_genotypes)
    Φ = genetics.Φ
    
    # Empty array of correct size 
    P0 = zeros(nP, gN)
    
    # Initialize at equilibrium: gene_index = each node initialized BY GENE
    P0[end, gene_index] = (NF*μF) / (nP*qP*Φ[gene_index]) 
    
    # Question: what if decide to initialize with pupae (also applicable to other stages)??
    # P0[end, gene_index] = P0_begin
    
    # Initialize remaining substages
    for i in nP-1:-1:1
        P0[i, gene_index] = ((μP + qP*nP)/(qP*nP)) * P0[i+1,gene_index]
    end   
    
    # Show result
    return P0

end

##############
# EGGS 
##############
# (β, NF, μE, qE, nE)

#function init_egg!(node::Node, gene_index::Int64)
function init_egg!(node::Node, gene_index::Int64, ctemp)
    
    # Access necessary stages via Node 
    female = get_stage(node, Female)
    NF = female.N0
    
    egg = get_stage(node, Egg)
    nE = egg.n
    #qE = egg.q
    qE = tempeffect_E(ctemp, egg.μ, egg.q)[2] 
    #μE = egg.μ
    μE = tempeffect_E(ctemp, egg.μ, egg.q)[1] 
    
    # Access necessary genetic info via Node
    genetics = get_genetics(node)
    gN = length(genetics.all_genotypes)
    Β = genetics.Β
    
    # Empty array of correct size 
    E0 = zeros(nE, gN)
    
    # Initialize at equilibrium: gene_index = each node initialized BY GENE
    E0[1,gene_index] = (Β[gene_index]*NF)/(μE + qE*nE)

    # Initialize remaining substages (populate each i, specific to gene_index)

    for i in 2:size(E0)[1]
        E0[i, gene_index] = (qE*nE*E0[i-1, gene_index]) / (μE + qE*nE)
    end    


    # Show result
    return E0

end

##############
# LARVAE 
##############
# (μP, qP, nP, qL, nL, P0, qE, nE, E0)  

function init_larvae!(node::Node, E0, P0, gene_index::Int64, ctemp)
    
    # Access necessary stages via Node
    female = get_stage(node, Female)
    NF = female.N0

    pupae = get_stage(node, Pupae)
    nP = pupae.n
    #qP = pupae.q
    qP = tempeffect_P(ctemp, pupae.μ, pupae.q)[2] 
    #μP = pupae.μ
    μP = tempeffect_P(ctemp, pupae.μ, pupae.q)[1] 

    egg = get_stage(node, Egg)
    nE = egg.n
    qE = egg.q
    
    larvae = get_stage(node, Larvae)
    nL = larvae.n
    #qL = larvae.q
    qL = tempeffect_L(ctemp, larvae.μ, larvae.q)[2]
    #μL = larvae.μ
    μL = tempeffect_L(ctemp, larvae.μ, larvae.q)[1] 
    
    # Access necessary genetic info via Node
    genetics = get_genetics(node)
    gN = length(genetics.all_genotypes)
    
    # Empty array of correct size 
    L0 = zeros(nL, gN)

    # Initialize final substage of larvae 
    L0[end, gene_index] = ((μP + qP*nP)/(qL*nL)) * P0[1, gene_index] 

    # For ease of forloop initialization 
    Lend = L0[end, gene_index]
    Eend = E0[end, gene_index]  

    # Initialize remaining substages
    for i in nL-1:-1:1
        L0[i,gene_index] = ((Lend^(i/nL)) * (Eend^((nL-i)/nL)) * (nE^((nL-i)/nL)) * (qE^((nL-i)/nL))) / ((nL^((nL-i)/nL)) * (qL^((nL-i)/nL)))

    end    
    
    # Show result
    return L0

end


##############
# ADULT MALES
##############
    
# (ϕ, qP, nP, P0, μM)
function init_male!(node::Node, P0, gene_index::Int64, ctemp)
    
    # Access necessary stages via Node 
    pupae = get_stage(node, Pupae)
    nP = pupae.n
    qP = pupae.q
    
    male = get_stage(node, Male) 
    #μM = male.μ
    μM = tempeffect_A(ctemp, male.μ) # Currently the same for Male and Female 

    # Access necessary genetic info via Node
    genetics = get_genetics(node)
    gN = length(genetics.all_genotypes)
    Φ = genetics.Φ
    
    # Empty array of correct size 
    M0 = zeros(1,gN)

    # Initialize male stage (no substages exist) for specific gene_index
    M0[1, gene_index] = ((1-Φ[gene_index])*qP*nP*P0[end, gene_index]) / μM

    # Show result
    return M0

end 

##############
# ADULT FEMALES
##############

function init_female!(node::Node, gene_index::Int64, ctemp) #ctemp useless here because temp doesn't affect init function - will this cause a problem with discrepancy between init and popequations? 
    
    # Access necessary stages via Node 
    female = get_stage(node, Female)
    F0_begin = female.N0
    # μF = tempeffect_A(ctemp, female.μ) # Not used for init function - should it be?
    
    # Access necessary genetic info via Node
    genetics = get_genetics(node)
    gN = length(genetics.all_genotypes)
    
    # Empty array of correct size 
    F0 = zeros(gN, gN)

    # Initialize female stage (no substages exist) for specific gene_index
    F0[gene_index, gene_index] = F0_begin

    # Show result
    return F0

end 

######################################
# Init entire node  at once, 
# get equilib values using NLSolve 
######################################

function init_node!(node::Node, gene_index::Int64)  
    
    # Temperature model
    ctemp = temp_model(node.temperature, 0)
    #@show (ctemp,t)
    
    # Init each stage separately; pupae always first 
    P0 = init_pupae!(node::Node, gene_index::Int64, ctemp) 
    E0 = init_egg!(node::Node,  gene_index::Int64, ctemp) # specify ctemp as Float64 once "nothing" placeholder is exchanged 
    L0 = init_larvae!(node::Node, E0, P0, gene_index::Int64, ctemp)   
    M0 = init_male!(node::Node, P0, gene_index::Int64, ctemp)  
    F0 = init_female!(node::Node, gene_index::Int64, ctemp) 
    
    # Create matrix of states for NLSolve
    u0_orig = vcat(E0, L0, P0, M0, F0)
    
    # Set controls to zero starting point -> one index per STATE (eg, M0) to which controls applied 
    controls = [0.0] 
    
    # Run NLSolve
    eq_pop = NLsolve.nlsolve((du,u) -> population_model_node(du, u, (node::Node, controls), 0), u0_orig)

    
    u0_new = eq_pop.zero
    
    return u0_new
    
end


#= 
OLD INIT_NODE!
    P0 = init_pupae!(nodes[1], 4) 
    E0 = init_egg!(nodes[1], 4)  
    L0 = init_larvae!(nodes[1], 4)  
    M0 = init_male!(nodes[1], 4) 
    F0 = init_female!(nodes[1], 4) 
    
    # Create matrix of states for NLSolve
    u0_orig = vcat(E0, L0, P0, M0, F0)? 

    controls = [0.0] 
    # Only one index because only adding to one state (males). If adding to another (eg, females), add a second index to the array and so on/ then it would be .p[2][2]

eq_pop = NLsolve.nlsolve((du,u) -> population_model(du, u, (nodes[1], controls), 0), u0_orig)
u0_new = eq_pop.zero
=#





