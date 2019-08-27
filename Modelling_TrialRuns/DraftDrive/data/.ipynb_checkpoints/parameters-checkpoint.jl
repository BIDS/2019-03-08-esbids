##### LyfeCycle Data #####

P_Egg = LifeCycle(Egg, 4, 4, 0.5, nothing, nothing);
P_Larvae = LifeCycle(Larvae, 3, 8, 0.15, nothing, nothing);
P_Pupae = LifeCycle(Pupae, 6, 6, 0.05, 0.001, 355.0);
P_Male = LifeCycle(MaleAdult, 1, 1, 0.09, nothing, nothing);
P_Female = LifeCycle(FemaleAdult, 1, 1, 0.09, nothing, nothing);


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


PopArray =	[GeneSpecificLife(HH, layer_HH, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GeneSpecificLife(Hh, layer_Hh, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GeneSpecificLife(HR, layer_HR, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GeneSpecificLife(hh, layer_hh, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GeneSpecificLife(hR, layer_hR, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])
			 GeneSpecificLife(RR, layer_RR, [P_Egg, P_Larvae, P_Pupae, P_Male, P_Female])];
	

base_population = Population(:Pop1, 16.0, 0.5, ones(6), ones(6,6,6), ones(6), 500, 500, PopArray)


