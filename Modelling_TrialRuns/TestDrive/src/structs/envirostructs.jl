"""
TODO: Include Temperature and Precipitation; possibly Humidity as a function of these two as well.  

"""


abstract type Temp end

struct NoTemp <: Temp end

struct ConstantTemp <: Temp 
    value::Float64
end

struct SinusoidalTemp <: Temp
    a::Float64
    b::Int64
    c::Int64
    d::Float64
end


#=

struct Temperature{T <: TempScenario}
    model::Type{T}  
end

struct Sinusoidal <: TempScenario end
struct Constant <: TempScenario end 


# Other options might include: 
struct LinearRamp <: TempScenario end
struct ExponentialRamp <: TempScenario end
struct Discontinuity <:  TempScenario end 

=#

