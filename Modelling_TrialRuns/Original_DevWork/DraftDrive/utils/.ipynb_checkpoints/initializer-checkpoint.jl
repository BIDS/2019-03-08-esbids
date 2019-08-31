# Pupae
function init_P(NF, μF, nP, qP, ϕ, μP)  
    P0 = zeros(6)  
    P0[end] = (NF*μF) / (nP*qP*ϕ)    
    for i in length(P0)-1:-1:1
        P0[i] = ((μP + qP*nP)/(qP*nP)) * P0[i+1]
    end   
    return P0    
end


# Eggs
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


# Larvae 
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


# Adult Males   
function init_NM(ϕ, qP, nP, P0, μM)
    NM = ((1-ϕ)*qP*nP*P0[end]) / μM
    return NM  
end

E0 = init_E(β, NF, μE, qE, nE)
P0 = init_P(NF, μF, nP, qP, ϕ, μP) 
L0 = init_L(μP, qP, nP, qL, nL, P0, qE, nE)
NM = init_NM(ϕ, qP, nP, P0, μM)
; 


