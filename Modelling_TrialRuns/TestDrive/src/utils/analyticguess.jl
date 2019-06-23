"""
Analytic calculations furnish "best guess" of equilibrium for each stage.

NB: Order must be preserved (pupae come first)

Question: The order becomes an issue if pupal stage not included, correct? How to adjust for maximized flexibility? 
Question: BUT if not all the same stages included, then the equilibrium will be different - must be made generic; do the equations allow for that? How to get around this part - any other way for applying nlsolve? would biostat community even be OK with something that doesn't have analytic eq calculated somewhere? 

"""


##############
# PUPAE
##############
# (NF, μF, nP, qP, ϕ, μP)

function init_stage!(P0::Array{Float64,2}, # Bring in matrix from init_node
                     s::Stage{Pupae}, 
                     stages, 
                     genetics::Genetics, 
                     gene_index::Int64)
    
    # Access external stages via "stages"
    female = get_stage(stages, Female)
    NF = female.N0
    μF = female.μ
    
    # Access necessary genetic info via genetics::Genetics
    ϕ = genetics.Φ[gene_index] 
    
    # Access stage-specific info via s::Stage{Pupae}
    nP = s.n
    qP = s.q
    μP = s.μ
    
    # Initialize at equilibrium: gene_index = each node initialized BY GENE
    P0[end, gene_index] = (NF*μF) / (nP*qP*ϕ) 
    
    # Initialize remaining substages
    for i in nP-1:-1:1
        P0[i, gene_index] = ((μP + qP*nP)/(qP*nP)) * P0[i+1,gene_index]
    end   
    
    # Show result
    return

end

##############
# EGGS 
##############
# (β, NF, μE, qE, nE)

function init_stage!(E0::Array{Float64,2}, # Bring in matrix from init_node
                     s::Stage{Egg}, 
                     stages, 
                     genetics::Genetics, 
                     gene_index::Int64)   # Note each gene initialized individually; 
                                          # only need wildtype in most cases 
    
    # Access external stages via "stages"
    female = get_stage(stages, Female)
    NF = female.N0
    
    # Access necessary genetic info via genetics::Genetics
    β = genetics.Β[gene_index]
    
    # Access stage-specific info via s::Stage{Egg}
    nE = s.n
    qE = s.q
    μE = s.μ

    # Initialize at equilibrium: gene_index = each node initialized BY GENE
    E0[1, gene_index] = β*NF / (μE + qE*nE)

    # Initialize remaining substages (populate each i, specific to gene_index)
    for i in 2:length(E0)
        E0[i, gene_index] = (qE*nE*E0[i-1, gene_index]) / (μE + qE*nE)
    end    

    # Show result
    return

end

##############
# LARVAE 
##############
# (μP, qP, nP, qL, nL, P0, qE, nE, E0)  

function init_stage!(L0::Array{Float64,2}, # Bring in matrix from init_node
                     s::Stage{Larvae}, 
                     stages, 
                     genetics::Genetics, 
                     gene_index::Int64,
                     P0::Array{Float64,2}, # Bring in matrix from init_node
                     E0::Array{Float64,2}) # Bring in matrix from init_node
    
    # Access external stages via "stages"
    female = get_stage(stages, Female)
    NF = female.N0

    pupae = get_stage(stages, Pupae)
    nP = pupae.n
    qP = pupae.q

    egg = get_stage(stages, Egg)
    nE = egg.n
    qE = egg.q
    
    # Access necessary genetic info via genetics::Genetics
    ϕ = genetics.Φ[gene_index]
    β = genetics.Β[gene_index]

    # Access stage-specific info via s::Stage{Larvae}
    nL = s.n
    qL = s.q
    μL = s.μ

    # Initialize final substage of larvae 
    L0[end, gene_index] = ((μP + qP*nP)/(qL*nL)) * P0[1, gene_index] 

    # For ease of forloop initialization 
    Lend = L0[end, gene_index]
    Eend = E0[end, gene_index]  

    # Initialize remaining substages
    for i in nL-1:-1:1
        L0[i,gene_index] = ((Lend^(i/nL)) * (Eend^((nL-i)/nL)) * (nE^((nL-i)/nL)) * 
            (qE^((nL-i)/nL))) / ((nL^((nL-i)/nL)) * (qL^((nL-i)/nL)))

    end    
    
    # Show result
    return

end
    
# QUESTION (for Sean): Why is μ for E and L stages not included in these calculations?

##############
# ADULT MALES
##############
    
# (ϕ, qP, nP, P0, μM)
function init_stage!(NM::Vector{Float64}, # Bring in matrix from init_node
                     s::Stage{Male}, 
                     stages, 
                     genetics::Genetics, 
                     gene_index::Int64,
                     P0::Array{Float64,2}) 
    
    # Access external stages via "stages"
    pupae = get_stage(stages, Pupae)
    nP = pupae.n
    qP = pupae.q

    # Access necessary genetic info via genetics::Genetics
    ϕ = genetics.Φ[gene_index]
    
    # Access stage-specific info via s::Stage{Male}
    μM = s.μ

    # Initialize male stage (no substages exist) for specific gene_index
    NM0[1, gene_index] = ((1-ϕ)*qP*nP*P0[end]) / μM

    # Show result
    return

end 

##############
# ADULT FEMALES
##############
# Not calculated: value determined by user when creating struct 
# Therefore the below function is mostly useful for situating desired beginning pop in correct gene_index 
# QUESTION: Is this true if the struct has already determined that? In struct, only N0 by stage not gene_index ->
# would it be best/better to initialize according to GENOTYPE? 

function init_stage!(NF::Array{Float64,2}, # Bring in matrix from init_node
                     s::Stage{Female}, 
                     gene_index::Int64) 
    
    # Access stage-specific info via s::Stage{Female}
    NF0 = s.N0

    # Initialize female stage (no substages exist) for specific gene_index
    NF0[gene_index, gene_index] = NF0

    # Show result
    return

end 

