###########################
# Calculate initial values 
# (all at equilibrium)
###########################

##### Pupae
function init_P(NF, μF, nP, qP, ϕ, μP)  
    P0 = zeros(6)  
    P0[end] = (NF*μF) / (nP*qP*ϕ)    
    for i in length(P0)-1:-1:1
        P0[i] = ((μP + qP*nP)/(qP*nP)) * P0[i+1]
    end   
    return P0    
end


##### Eggs
function init_E(β, NF, μE, qE, nE)
    # placeholder for each day of history 
    E0 = zeros(4)    
    # initialize at equilibrium  
    E0[1] = β*NF / (μE + qE*nE)   
    # obtain values for each day of history based on eq 
    for i in 2:length(E0)
        E0[i] = (qE*nE*E0[i-1]) / (μE + qE*nE)
    end    
    # show result
    return E0
end


##### Larvae 
function init_L(μP, qP, nP, qL, nL, P0, qE, nE)  
    L0 = zeros(8)
    L0[end] = ((μP + qP*nP)/(qL*nL)) * P0[1] 
    Lend = L0[end]
    Eend = E0[end]  
    for i in length(L0)-1:-1:1
        L0[i] = ((Lend^(i/nL)) * (Eend^((nL-i)/nL)) * (nE^((nL-i)/nL)) * (qE^((nL-i)/nL))) / 
        ((nL^((nL-i)/nL)) * (qL^((nL-i)/nL)))
    end    
    return L0   
end


##### Adult Males   
function init_NM(ϕ, qP, nP, P0, μM)
    NM = ((1-ϕ)*qP*nP*P0[end]) / μM
    return NM  
end


##### Adult Females 
# Simply wildtype = 500



###########################
# Apply functions 
###########################
E0 = init_E(β, NF, μE, qE, nE)
P0 = init_P(NF, μF, nP, qP, ϕ, μP) 
L0 = init_L(μP, qP, nP, qL, nL, P0, qE, nE)
NM = init_NM(ϕ, qP, nP, P0, μM)
; 



###########################
# Create life structures
########################### 
eggs = AxisArray(zeros(4,6), 
    1:4, ["HH", "Hh", "HR", "hh", "hR", "RR"])
larvae = AxisArray(zeros(8,6), 
    1:8, ["HH", "Hh", "HR", "hh", "hR", "RR"])
pupae = AxisArray(zeros(6,6), 
    1:6, ["HH", "Hh", "HR", "hh", "hR", "RR"])
females = AxisArray(zeros(6,6), 
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])
males = AxisArray(zeros(1,6), 
    1:1, ["HH", "Hh", "HR", "hh", "hR", "RR"])
females = AxisArray(zeros(6,6), 
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])
; 



###########################
# Create "hh" structure with calculated values  
########################### 

init_eggs = AxisArray([7619.04  7256.24  6910.7  6581.62], 
    ["hh"])
init_larvae = AxisArray([1497.08  908.083  550.815  334.108  202.66  122.927  74.5639  45.2282], 
    ["hh"])
init_pupae = AxisArray([114.865  109.396  104.186  99.225  94.5  90.0], 
    ["hh"])



###########################
# Insert values into larger structure 
########################### 

eggs[:, ["hh"]] = init_eggs
larvae[:, ["hh"]] = init_larvae
pupae[:, ["hh"]] = init_pupae
males[1,["hh"]] = [500.0]
females[["hh"],["hh"]] = [500.0]


###########################
# Rename adults to match structures created above 
# with terms used in code going forward  
########################### 

NM = males 
NF = females
;



###########################
# Setup DiffEq input: u0   
###########################

# Males 
u0_males = males 

# Females existing init matrix sliced according to row genotype. 
u0_females_HH = females[["HH"],:]  
u0_females_Hh = females[["Hh"],:]  
u0_females_HR = females[["HR"],:]  
u0_females_hh = females[["hh"],:]  
u0_females_hR = females[["hR"],:]  
u0_females_RR = females[["RR"],:]  

#### Juvenile stages = existing init matrix sliced according to life substage.
# Eggs 
u0_eggs1 = transpose(eggs[1,:])
u0_eggs2 = transpose(eggs[2,:])
u0_eggs3 = transpose(eggs[3,:])
u0_eggs4 = transpose(eggs[4,:])

# Larvae
u0_larvae1 = transpose(larvae[1, :])  
u0_larvae2 = transpose(larvae[2, :])  
u0_larvae3 = transpose(larvae[3, :])  
u0_larvae4 = transpose(larvae[4, :])  
u0_larvae5 = transpose(larvae[5, :])  
u0_larvae6 = transpose(larvae[6, :])  
u0_larvae7 = transpose(larvae[7, :])  
u0_larvae8 = transpose(larvae[8, :])  

# Pupae 
u0_pupae1 = transpose(pupae[1, :])    
u0_pupae2 = transpose(pupae[2, :])   
u0_pupae3 = transpose(pupae[3, :])   
u0_pupae4 = transpose(pupae[4, :])   
u0_pupae5 = transpose(pupae[5, :])   
u0_pupae6 = transpose(pupae[6, :])   

#### concatenate and create u0 array for full population
u0_array = vcat(u0_eggs1, u0_eggs2, u0_eggs3, u0_eggs4, 
    u0_larvae1, u0_larvae2, u0_larvae3, u0_larvae4, 
    u0_larvae5, u0_larvae6, u0_larvae7, u0_larvae8, 
    u0_pupae1, u0_pupae2, u0_pupae3, u0_pupae4, u0_pupae5, u0_pupae6,
    u0_males, u0_females_HH, u0_females_Hh, u0_females_HR,
    u0_females_hh, u0_females_hR, u0_females_RR)
;


