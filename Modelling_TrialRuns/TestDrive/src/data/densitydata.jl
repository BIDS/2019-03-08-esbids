"""

Generate alternativesfor density specification 

"""


dens_lin = Density(LinearDens, 5.0)         # This parameter is made up.

dens_log = Density(LogisticDens, 355.0)     # This parameter is checked against MGDrivE (BUT VERIFIED FOR LARVAE ONLY) -> NB for decision model that this is fine 


dens_none = Density(NoDens, 1.0)            # NB that "no density" uses 1.0 here because in current model, density dependent death is implemented multiplicatively. If changed to additive, this function should be updated to use 0.0 as the parameter. Should never use "nothing" unless refrain entirely from specifying density. 