"""

Generate temperature data for different climate models 

"""


# Testing options; these don't correspond to realistic scenarios 
temp_none = NoTemp() 

temp_constant = ConstantTemp(30.0)

temp_sinusoidal = SinusoidalTemp(7.5, 2, 365, 21.5)