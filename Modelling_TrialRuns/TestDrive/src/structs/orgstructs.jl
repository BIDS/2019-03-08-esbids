"""
Structs for different built-in insect types; enables use of multiple dispatch. NB, this can also be used to portray natural predators of insect being studied (eg, spiders and mosquitos in same node).

TODO:
(1) Brainstorm and add new organisms. Mosquito subspecies, eg Anopheles Gambiea in addition to different insects, eg Asian Citrus Psyllid. 
(2) See embedded questions. 

"""



## Stage
abstract type Insect end 

struct Organism{I <: Insect}
    name::Symbol                 # Name 
    # anything else?? Not initial count because that is done by lifestage in the Stage struct 
end


# Mosquito could also be sub-typed into anopheles, aedes, etc -> display different eg *density dependence* or **migration tendences** 
struct Mosquito <: Insect end