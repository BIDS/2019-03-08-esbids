struct Cube 
	s::Vector{<:Real}
	τ::Array{<:Real,3}
	η::Vector{<:Real}
	ih::Array{<:Real,3}
	
	function Cube(s::Vector{<:Real}, 
			      τ::Array{<:Real,3}, 
			      η::Vector{<:Real}, 
			      genotypes::Vector{GeneSpecificLife{<:Genotype}}) 
		# Populate the cube 
		GN = length(genotypes)
		cube_array = Array{Float64, 3}(undef, GN, GN, GN)
		for (ix, g) in enumerate(genotypes)
			cube_array[:,:,ix] = g.cube_layer 
		end
		new(s, τ, η, cube_array)
	end
end

struct Reproduction
	β::Float64  # Fecundity
	ϕ::Float64  # Male/Female Ratio
	cube::Cube
	NM0::Int64
	NF0::Int64
end

struct Population
	name::Symbol
	genotypes::Vector{GeneSpecificLife{<:Genotype}}
	reproduction::Reproduction

	function Population(name::Symbol, 	 
					    β::Float64, 
						ϕ::Float64, 
						s::Vector{<:Real}, 
						τ::Array{<:Real,3},
						η::Vector{<:Real},
						NM0::Int64,
						NF0::Int64,
						genotypes::Vector{GeneSpecificLife{<:Genotype}})
		
				cube = Cube(s, τ, η, genotypes)
				R = Reproduction(β, ϕ, cube, NM0, NF0)
		
				new(name, genotypes, R)
		
	end
	
end


