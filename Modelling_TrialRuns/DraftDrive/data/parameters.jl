###########################
# Populate each life stage 
###########################

# LifeParameters(stage descriptor, stage duration, number of bins, mortality, dd linear, dd logistic)  
P_Egg = LifeParameters(Egg, 4, 4, 0.5, nothing, nothing);
P_Larvae = LifeParameters(Larvae, 3, 8, 0.15, nothing, 355.0);
P_Pupae = LifeParameters(Pupae, 6, 6, 0.05, nothing, nothing);
P_Male = LifeParameters(MaleAdult, 1, 1, 0.09, nothing, nothing);
P_Female = LifeParameters(FemaleAdult, 1, 1, 0.09, nothing, nothing);



###########################
# Create cube by layer ->
# order by offspring genotype 
###########################

# Each layer (offspring genotype) = matrix ->
# female rows = ["HH", "Hh", "HR", "hh", "hR", "RR"], male cols = ["HH", "Hh", "HR", "hh", "hR", "RR"]
layer_HH = AxisArray([1.0 1.0 0.50  0  0  0; 
					  1.0 1.0 0.50  0  0  0; 
					  0.5 0.5 0.25  0  0  0; 
					  0.0 0.0 0.00  0  0  0; 
					  0.0 0.0 0.00  0  0  0; 
					  0.0 0.0 0.00  0  0  0],
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])

layer_Hh = AxisArray([0.0 0.0 0.00 1.0 0.50  0; 
					  0.0 0.0 0.00 1.0 0.50  0; 
					  0.0 0.0 0.00 0.5 0.25  0; 
					  1.0 1.0 0.50 0.0 0.00  0; 
					  0.5 0.5 0.25 0.0 0.00  0; 
					  0.0 0.0 0.00 0.0 0.00  0],
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])

layer_HR = AxisArray([0.0 0.0 0.50  0 0.50 1.0; 
					  0.0 0.0 0.50  0 0.50 1.0; 
					  0.5 0.5 0.50  0 0.25 0.5;
					  0.0 0.0 0.00  0 0.00 0.0;
					  0.5 0.5 0.25  0 0.00 0.0;
				      1.0 1.0 0.50  0 0.00 0.0],
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])

layer_hh = AxisArray([0  0  0 0.0 0.00  0; 
						0  0  0 0.0 0.00  0; 
						0  0  0 0.0 0.00  0; 
						0  0  0 1.0 0.50  0; 
						0  0  0 0.5 0.25  0; 
						0  0  0 0.0 0.00  0],
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])

layer_hR = AxisArray([0  0  0 0.0 0.00  0; 
						0  0  0 0.0 0.00  0; 
						0  0 0.00 0.5 0.25 0.0; 
						0  0 0.50 0.0 0.50 1.0; 
						0  0 0.25 0.5 0.50 0.5; 
						0  0 0.00 1.0 0.50 0.0],
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])

layer_RR = AxisArray([0  0  0 0.0 0.00  0; 
		              0  0  0 0.0 0.00  0; 
		              0  0 0.25  0 0.25 0.5; 
					  0  0 0.00  0 0.00 0.0; 
					  0  0 0.25  0 0.25 0.5; 
					  0  0 0.50  0 0.50 1.0],
    ["HH", "Hh", "HR", "hh", "hR", "RR"], ["HH", "Hh", "HR", "hh", "hR", "RR"])


###########################
# Create the population
###########################

#= Define population members by genotype and life stage: 
1. Members include many genotypes
2. Each genotype goes through all lifestages
3. Specifics of your life stage depend on your genes
=# 
PopArray =	[GenesDefineLife(HH, layer_HH, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GenesDefineLife(Hh, layer_Hh, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GenesDefineLife(HR, layer_HR, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GenesDefineLife(hh, layer_hh, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GenesDefineLife(hR, layer_hR, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GenesDefineLife(RR, layer_RR, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])];
	

#= Assemble the base pop! 
Specify population type -> name, fecundity, gender breakdown, s, τ, η, initM, initF, popmembers_by_genotype 
=#
base_population = PopulationType(:Pop1, 16.0, 0.5, ones(6), ones(6,6,6), ones(6), 500, 500, PopArray)

########################## QUESTION WHERE IS CUBE IN THE ABOVE BASE POP, WHY CALLING UNNECESSARY PARTS???? 