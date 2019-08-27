###########################
# Drive parameters 
###########################

struct Cube 
	s::Vector{<:Real}
	τ::Array{<:Real,3}
	η::Vector{<:Real}
	ih::Array{<:Real,3}

##################################################### QUESTION WHY NEED GENOTYPE LAYERS IF HAVE IH?
    
    # Build the cube 
	function Cube(s::Vector{<:Real}, 
			      τ::Array{<:Real,3}, 
			      η::Vector{<:Real}, 
            
            ########################### QUESTION WHY GENOTYPES NOT IH, AND WHY GENES DEFINE LIFE HERE?????
			      genotypes::Vector{GenesDefineLife{<:Genotype}}) 

##################################################### QUESTION WHAT IS IX, AND WHY DOES THIS LOOPING WORK TO CREATE LAYERS
##################################################### QUESTION IS THIS ACTUALLY IH? DOES IT TAKE THE PLACE OF LAYERS ON OTHER PAGE? 
        # Populate the cube 
		GN = length(genotypes)
		cube_array = Array{Float64, 3}(undef, GN, GN, GN)
		for (ix, g) in enumerate(genotypes)
			cube_array[:,:,ix] = g.cube_layer 
		end

##################################################### QUESTION WHERE IS IH PART? WHY CUBE ARRAY NOT CUBE??????
        new(s, τ, η, cube_array)
	end
end


###########################
# Reproduction   
###########################

struct Reproduction
	β::Float64  # Fecundity
	ϕ::Float64  # Gender
	cube::Cube  # Drive parameters 
##################################################### QUESTION WHY ARE M0 AND NF0 HERE IF CALC ELSEWHERE?  
	NM0::Int64  # Initial males 
	NF0::Int64  # Initial females 
end



###########################
# Population type 
###########################

struct PopulationType
	name::Symbol
	genotypes::Vector{GenesDefineLife{<:Genotype}}
	reproduction::Reproduction

	function PopulationType(name::Symbol, 	 
            ##################################################### QUESTION WHY REPEAT ALL THIS IF HAVE ELSEWHERE? 
					    β::Float64, 
						ϕ::Float64, 
						s::Vector{<:Real}, 
						τ::Array{<:Real,3},
						η::Vector{<:Real},
            ##################################################### QUESTION WHY ARE M0 AND NF0 HERE AGAIN IF (1) IN REPRODUCTION AND (2) CALC ELSEWHERE ? WHY NOT INITIALIZING ANY OTHER LIFE STAGE VALUES? 
						NM0::Int64,
						NF0::Int64,
						genotypes::Vector{GenesDefineLife{<:Genotype}})
		##################################################### QUESTION WHY both cube and reproduction these should be the same 
				cube = Cube(s, τ, η, genotypes)
				R = Reproduction(β, ϕ, cube, NM0, NF0)
		
				new(name, genotypes, R)
		
	end
	
end


