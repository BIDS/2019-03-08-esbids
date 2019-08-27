"""
Functions required for Temperature (eventally, Precipitation and Humidity as well)

TODO: 
(1) Consider altitude + lat/long overlay on a map with proper migration 
(2) Temp generating model should be different for each node based on geography (lat/long/alt).
"""


#####################################################
# PART 1: Model temperature 
## (each node)
#####################################################


# No temperature effects 
function temp_model(data::NoTemp, t)
   return
end

# Constant temperature effects 
function temp_model(data::ConstantTemp, t)
   return data.value
end


# Sinusoidal temperature effects 
## NB: cos formulation implies Southern Hemisphere; highest temps in January and lowest in July
function temp_model(data::SinusoidalTemp, t)
   return data.a * cos((data.b*π/data.c)*t) + data.d  # for decision model, feed this in as external data to avoid issue of nonlinearity 
end



#####################################################
# PART 2: Display the effect of temperature 
## (each lifestage and parameter)
#####################################################

# Egg mortality + duration 
function tempeffect_E(ctemp, μ, q) # testcase = mu is 0.05, q is 1/4
    
    if ctemp isa Float64 # OR if ctemp is !== nothing (NB two equal signs if testing for nothing, 
                         # and if equlity with nothing or missing, use x === nothing)
        
        # acquatic stages assume Tw = Ta + 2celsius per Abiodun et al 2016 
        ctemp += 2 
        
        # returns tuple of the temperature affected parameters 
        return μ*0.066*ctemp^3 - μ*4.6*ctemp^2 + μ*106.0*ctemp - 40.0,
        q*0.048*ctemp^3 - q*3.24*ctemp^2 + q*72.0*ctemp - 135.93
        
    else
        # returns tuple of the original parameters 
        return μ, q
    end
end
    

# Larval mortality + duration 
function tempeffect_L(ctemp, μ, q) # testcase = mu is 0.15, q is 1/3
    
    if ctemp isa Float64 
            
        ctemp += 2 
            
        return μ*0.0054*ctemp^3 - μ*0.3733*ctemp^2 + μ*8.6667*ctemp - 8.6, 
            q*-0.006*ctemp^3 + q*0.42*ctemp^2 - q*9.0*ctemp + 22.0
            
    else
        return μ, q
    end
end
   
        
        
# Pupal mortality + duration 
function tempeffect_P(ctemp, μ, q) # testcase = mu is 0.05, q is 1/6
    
    if ctemp isa Float64 
                
        ctemp += 2 
                
        return μ*0.68*ctemp^3 - μ*4.3999*ctemp^2 - μ*98.0*ctemp - 34.0, 
                q*-0.0108*ctemp^3 + q*0.72*ctemp^2 - q*16.20*ctemp + 20.0
    else
        return μ, q
    end
end

            
# Adult (currently both M and F equivalent) mortality; no duration necessary
#### NB if assume different μ for male versus female, this needs to split into two. 
function tempeffect_A(ctemp, μ) # testcase = mu is 0.09
    
    if ctemp isa Float64 # Note for adults ctemp = Ta with no changes necessary 

        return μ*-0.00101111*ctemp^3 + μ*6.5556*ctemp^2 + μ*14.4444*ctemp + 9.9
                    
    else
        return μ
    end
end