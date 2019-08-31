"""

Establishes time points for control, DiscreteCallback interface conditions, effect of reaching those conditions; saves positions and creates callback set. 

TODO: 
(1) How to clean up callbacks - possible to use loops? 
(2) Create struct for controls: condition vector, effects, etc as fields. User should be able to only provide intervantion times and values (eg, optimal policy results from decision model) - everything else then created in the background. 

"""

#=
# Time points at which f1 will change 
const tstop1 = [2.]
const tstop2 = [3.]
const tstop3 = [4.]
const tstop4 = [5.]
const tstop5 = [6.]
const tstop6 = [7.]
const tstop7 = [8.]
const tstop8 = [9.]
const tstop9 = [10.]
const tstop10 = [11.]
const tstop = [2.,3.,4.,5.,6.,7.,8.,9.,10.,11.]


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
    integrator.p[2][1] = 20.
end

function effect2!(integrator)
    integrator.p[2][1] = 0.            
end                     
    
function effect3!(integrator)
    integrator.p[2][1] = 20.
end    

function effect4!(integrator)
    integrator.p[2][1] = 0.
end    

function effect5!(integrator)
    integrator.p[2][1] = 20.
end   

function effect6!(integrator)
    integrator.p[2][1] = 0.
end    

function effect7!(integrator)
    integrator.p[2][1] = 20.
end  

function effect8!(integrator)
    integrator.p[2][1] = 0.
end  

function effect9!(integrator)
    integrator.p[2][1] = 20.
end  

function effect10!(integrator)
    integrator.p[2][1] = 0.
end  

#=
Syntax: (integrator.p[2][1] = 50.) => 
Because controls is the second in the the tuple "p" (named arbitrarily to represent params) where p = (node, controls). 
For second control, because control is a vector, simply index [2][2]. Note that this implies a control on a second state. 
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
=#

#### PRE DECISION MODEL ####

#=

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

=#


##### SIT ######



# Time points at which f1 will change 
const tstop1 = [2.]
const tstop2 = [3.]
const tstop3 = [4.]
const tstop4 = [5.]
const tstop5 = [6.]
const tstop6 = [7.]
const tstop7 = [8.]
const tstop8 = [9.]
const tstop9 = [10.]
const tstop10 = [11.]
const tstop11 = [12.]
const tstop12 = [13.]
const tstop13 = [14.]
const tstop14 = [15.]
const tstop15 = [16.]
const tstop16 = [17.]
const tstop17 = [18.]
const tstop18 = [19.]
const tstop19 = [20.]
const tstop20 = [21.]

const tstop = [2., 3., 4., 5., 6., 7., 8., 9., 10., 11., 12., 13., 14., 15., 16., 17., 18., 19., 20.]


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

function condition11(u, t, integrator)
    t in tstop11
end

function condition12(u, t, integrator)
    t in tstop12
end

function condition13(u, t, integrator)
    t in tstop13
end

function condition14(u, t, integrator)
    t in tstop14
end

function condition15(u, t, integrator)
    t in tstop15
end

function condition16(u, t, integrator)
    t in tstop16
end

function condition17(u, t, integrator)
    t in tstop17
end

function condition18(u, t, integrator)
    t in tstop18
end

function condition19(u, t, integrator)
    t in tstop18
end

function condition20(u, t, integrator)
    t in tstop18
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

function effect11!(integrator)
    integrator.p[2][1] = 50.
end  

function effect12!(integrator)
    integrator.p[2][1] = 0.
end  

function effect13!(integrator)
    integrator.p[2][1] = 50.
end  

function effect14!(integrator)
    integrator.p[2][1] = 0.
end  

function effect15!(integrator)
    integrator.p[2][1] = 50.
end  

function effect16!(integrator)
    integrator.p[2][1] = 0.
end  


function effect17!(integrator)
    integrator.p[2][1] = 50.
end  

function effect18!(integrator)
    integrator.p[2][1] = 0.
end  


function effect19!(integrator)
    integrator.p[2][1] = 50.
end  



function effect20!(integrator)
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
cb11 = diffeqCB.DiscreteCallback(condition11, effect11!, save_positions=save_positions)
cb12 = diffeqCB.DiscreteCallback(condition12, effect12!, save_positions=save_positions)
cb13 = diffeqCB.DiscreteCallback(condition13, effect13!, save_positions=save_positions)
cb14 = diffeqCB.DiscreteCallback(condition14, effect14!, save_positions=save_positions)
cb15 = diffeqCB.DiscreteCallback(condition15, effect15!, save_positions=save_positions)
cb16 = diffeqCB.DiscreteCallback(condition16, effect16!, save_positions=save_positions)
cb17 = diffeqCB.DiscreteCallback(condition17, effect17!, save_positions=save_positions)
cb18 = diffeqCB.DiscreteCallback(condition18, effect18!, save_positions=save_positions)
cb19 = diffeqCB.DiscreteCallback(condition19, effect19!, save_positions=save_positions)
cb20 = diffeqCB.DiscreteCallback(condition20, effect20!, save_positions=save_positions)


# Put it all together 
cbs = diffeqCB.CallbackSet(cb1, cb2, cb3, cb4, cb5, cb6, cb7, cb8, cb9, cb10, cb11, cb12, cb13, cb14, cb15, cb16, cb17, cb18, cb19, cb20)



;



