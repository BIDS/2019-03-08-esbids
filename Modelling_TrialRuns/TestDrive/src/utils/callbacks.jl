"""

Establishes time points for control, DiscreteCallback interface conditions, effect of reaching those conditions; saves positions and creates callback set. 

TODO: 
(1) How to clean up callbacks - possible to use loops? 
(2) Create struct for controls: condition vector, effects, etc as fields. User should be able to only provide intervantion times and values (eg, optimal policy results from decision model) - everything else then created in the background. 

"""


# Time points at which f1 will change 
const tstop1 = [25.]
const tstop2 = [26.]
const tstop3 = [35.]
const tstop4 = [36.]
const tstop5 = [45.]
const tstop6 = [46.]
const tstop7 = [55.]
const tstop8 = [56.]
const tstop9 = [65.]
const tstop10 = [66.]
const tstop = [25.,26.,35.,36.,45.,46.,55., 56., 65., 66.]


# Use DiscreteCallback interface to encode the conditions 
function condition1(u, t, integrator)
    t in tstop1
end

function condition2(u, t, integrator)
    t in tstop2
end

function condition3(u, t, integrator)
    t in tstop3
end

function condition4(u, t, integrator)
    t in tstop4
end

function condition5(u, t, integrator)
    t in tstop5
end

function condition6(u, t, integrator)
    t in tstop6
end

function condition7(u, t, integrator)
    t in tstop7
end

function condition8(u, t, integrator)
    t in tstop8
end

function condition9(u, t, integrator)
    t in tstop9
end

function condition10(u, t, integrator)
    t in tstop10
end


# State the effect of reaching established "conditions" (stated time points, above)
function effect1!(integrator)
    # @show integrator.p[2]
    integrator.p[2][1] = 50.
end

function effect2!(integrator)
    integrator.p[2][1] = 0.            
end                     
    
function effect3!(integrator)
    integrator.p[2][1] = 50.
end    

function effect4!(integrator)
    integrator.p[2][1] = 0.
end    

function effect5!(integrator)
    integrator.p[2][1] = 50.
end   

function effect6!(integrator)
    integrator.p[2][1] = 0.
end    

function effect7!(integrator)
    integrator.p[2][1] = 50.
end  

function effect8!(integrator)
    integrator.p[2][1] = 0.
end  

function effect9!(integrator)
    integrator.p[2][1] = 50.
end  

function effect10!(integrator)
    integrator.p[2][1] = 0.
end  

#=
Syntax: (integrator.p[2][1] = 50.) => 
Because controls is the second in the the tuple "p" (named arbitrarily to represent params) where p = (node, controls). For second control, because control is a vector, simply index [2][2]. Note that this implies a control on a second state. 
=#

# Save all positions; loop through and update all internal caches 
save_positions = (true, true)

# Set up each callback 
cb1 = diffeqCB.DiscreteCallback(condition1, effect1!, save_positions=save_positions)

cb2 = diffeqCB.DiscreteCallback(condition2, effect2!, save_positions=save_positions)      

cb3 = diffeqCB.DiscreteCallback(condition3, effect3!, save_positions=save_positions)                                         
cb4 = diffeqCB.DiscreteCallback(condition4, effect4!, save_positions=save_positions)                                           
cb5 = diffeqCB.DiscreteCallback(condition5, effect5!, save_positions=save_positions)                                            
cb6 = diffeqCB.DiscreteCallback(condition6, effect6!, save_positions=save_positions)                                           
cb7 = diffeqCB.DiscreteCallback(condition7, effect7!, save_positions=save_positions)                                          
cb8 = diffeqCB.DiscreteCallback(condition8, effect8!, save_positions=save_positions)                                         
cb9 = diffeqCB.DiscreteCallback(condition9, effect9!, save_positions=save_positions)  

cb10 = diffeqCB.DiscreteCallback(condition10, effect10!, save_positions=save_positions)

# Put it all together 
cbs = diffeqCB.CallbackSet(cb1, cb2, cb3, cb4, cb5, cb6, cb7, cb8, cb9, cb10)






#= ORIGINAL CALLBACK SETUP 

# Mutable struct employing DEDataVectors is NOT necessary if using callbacks as parameters 
mutable struct SimType{T} <: diffeqCB.DEDataMatrix{T}
    x::Array{T,2}
    f1::T
end
u0 = SimType(u0_new, 0.0)



function effect1!(integrator)
    for c in full_cache(integrator)
        c.f1 = 50.           
    end
end

    
function effect2!(integrator)
    for c in full_cache(integrator)
        c.f1 = 0.       
    end               
end                     
    
function effect3!(integrator)
    for c in full_cache(integrator)
        c.f1 = 50.           
    end
end    

function effect4!(integrator)
    for c in full_cache(integrator)
        c.f1 = 0.           
    end
end    

function effect5!(integrator)
    for c in full_cache(integrator)
        c.f1 = 50.           
    end
end   

function effect6!(integrator)
    for c in full_cache(integrator)
        c.f1 = 0.           
    end
end    

function effect7!(integrator)
    for c in full_cache(integrator)
        c.f1 = 50.           
    end
end  

function effect8!(integrator)
    for c in full_cache(integrator)
        c.f1 = 0.           
    end
end  

function effect9!(integrator)
    for c in full_cache(integrator)
        c.f1 = 50.           
    end
end  

function effect10!(integrator)
    for c in full_cache(integrator)
        c.f1 = 0.           
    end
end  

=#

;



