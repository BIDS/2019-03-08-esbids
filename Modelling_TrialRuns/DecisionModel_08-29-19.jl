
#cd("TestDrive")
using JuMP, Ipopt #, GLPK

using PyPlot
#using Plots
#gr()
;

include("src/TestDrive.jl")

# REMOVE MIGRATION FROM NODES FOR FUTURE USE -
# SHOULD ONLY OCCUR IN NETWORK STRUCT:
migrate1 = rand((6*(4+8+6+1+6)), 2, 2)

# User-named node
firstnode = :FirstNode

# User-constructed node: (name, gene_data, stages, location, migration_matrix)
node = Node(:FirstNode, genetics_mcr, stages_aedes, temp_none, (37.87, 122.27), migrate1)

;

# init_node!(desired_node, gene_index)
u0 = init_node!(node, 4)
;

# Network elements
# node_count = length(get_nodes(network))

# Genetics elements
genetics = get_genetics(node)
gN = length(genetics.all_genotypes)
cube = genetics.cube
S = genetics.S
Τ = genetics.Τ
Β = genetics.Β
Φ = genetics.Φ
Η = genetics.Η

;

# Lifestage elements
(e, l, p, m, f) = get_allstages(node)

# Mortality
μE = e.μ
μL = l.μ
μP = p.μ
μM = m.μ
μF = f.μ

# Substages
nE = e.n
nL = l.n
nP = p.n
nM = m.n
nF = f.n

# Duration (only juveniles for now - though this should/might change with migration implemented)
qE = e.q
qL = l.q
qP = p.q

# Density
densE = e.density
densL = l.density
densP = p.density
densM = m.density
densF = f.density

;

# Time
T = 1:300

# Stages and substages
SE = 1:nE
SL = 1:nL
SP = 1:nP
SM = 1:nM
SF = 1:nF*gN

# Genetics
G = 1:gN

# Nodes
# N = 1:node_count

# Slicing u0
E0 = u0[SE,:]
L0 = u0[nE+1:nL+nE,:]
P0 = u0[nE+nL+1:nE+nL+nP,:]
M0 = u0[nE+nL+nP+1,:]'
F0 = u0[nE+nL+nP+2:end,:];

# Use Pardiso solver 
#i = with_optimizer(Ipopt.Optimizer, linear_solver = "Pardiso")
#model = Model(i);

# Use mumps solver that comes with Ipopt
model = Model(with_optimizer(Ipopt.Optimizer))

# Eggs
@variable(model, E[SE, G, T] >= 0)
# Larvae
@variable(model, L[SL, G, T] >= 0)
# Pupae
@variable(model, P[SP, G, T] >= 0)
# Males
@variable(model, M[SM, G, T] >= 0)
# Females
@variable(model, F[SF, G, T] >= 0)

# Set starting values for each time step 
for t in T
    set_start_value.(E[:,:,t].data, E0)
    set_start_value.(F[:,:,t].data, F0)
    set_start_value.(M[:,:,t].data, M0)
    set_start_value.(L[:,:,t].data, L0)
    set_start_value.(P[:,:,t].data, P0)
end


# Test the addition of modified organisms
@variable(model, 0.0 <= control[G, T] <= 20)

# Fix the values of all genotypes other than homozygous drive 
for g in G[2:end]
    fix.(control[g, :], 0.0; force = true)
end

# Fix the values of all genotypes including homozygous drive for the first timestep 
fix.(control[:, 1], 0.0; force = true)
;

### Constraints 

# Eggs
@constraint(model, E_con_A0[s = SE[1], g = G, t = T[1]],
                   E[s, g, t] == E0[s, g] +
                                 sum(cube[:,:,g].*Τ[:,:,g].*S[g]*Β[g].*F[:,:,t].data) -
                                  E[s, g, t] * (μE*compute_density(densE, sum(E[:, :, t])) + qE*nE))
;

@constraint(model, E_con_A1[s = SE[1], g = G, t = T[2:end]],
                   E[s, g, t] ==  E[s, g, t-1] +
                                  sum(cube[:,:,g].*Τ[:,:,g].*S[g]*Β[g].*F[:,:,t].data) -
                                  E[s, g, t] * (μE*compute_density(densE, sum(E[:, :, t])) + qE*nE))

;

# Keep or no?
@constraint(model, E_con_B0[s = SE[2:end], g = G, t = T[1]] ,
                  E[s, g, t] ==   E0[s, g] +
                                  qE*nE*E[s-1, g, t] -
                                  E[s, g, t] * (μE*compute_density(densE, sum(E[:, :, t])) + qE*nE))
;

@constraint(model, E_con_B1[s = SE[2:end], g = G, t = T[2:end]] ,
                  E[s, g, t] ==   E[s, g, t-1] +
                                  qE*nE*E[s-1, g, t] -
                                  E[s, g, t] * (μE*compute_density(densE, sum(E[:, :, t])) + qE*nE))
;

# Larvae
@constraint(model, L_con_A0[s = SL[1], g = G, t = T[1]],
                   L[s, g, t] ==  L0[s, g] +
                                  qE * nE * E[end,g,t] -
                                  L[s, g, t] * (μL*compute_density(densL, sum(L[:, :, t])) + qL*nL))

;

@constraint(model, L_con_A1[s = SL[1], g = G, t = T[2:end]],
                   L[s, g, t] ==  L[s, g, t-1] +
                                  qE * nE * E[end,g,t] -
                                  L[s, g, t] * (μL*compute_density(densL, sum(L[:, :, t])) + qL*nL))

;

@constraint(model, L_con_B0[s = SL[2:end], g = G, t = T[1]],
                   L[s, g, t] == L0[s, g] +
                                 qL*nL*L[s-1, g, t] -
                                 L[s, g, t] * (μL*compute_density(densL, sum(L[:, :, t])) + qL*nL))

;

@constraint(model, L_con_B1[s = SL[2:end], g = G, t = T[2:end]],
                   L[s, g, t] == L[s, g, t-1] +
                                 qL*nL*L[s-1, g, t] -
                                 L[s, g, t] * (μL*compute_density(densL, sum(L[:, :, t])) + qL*nL))
;

# Pupae
@constraint(model, P_con_A0[s = SP[1], g = G, t = T[1]],
                   P[s, g, t] ==  P0[s, g] +
                                  qL * nL * L[end , g ,t] -
                                  P[s, g, t] * (μP*compute_density(densP, sum(L[:, :, t])) + qP*nP))

;

@constraint(model, P_con_A1[s = SP[1], g = G, t = T[2:end]],
                   P[s, g, t] ==  P[s, g, t-1] +
                                  qL * nL * L[end , g ,t] -
                                  P[s, g, t] * (μP*compute_density(densP, sum(L[:, :, t])) + qP*nP))

;

@constraint(model, P_con_B0[s = SP[2:end], g = G, t = T[1]] ,
                   P[s, g, t] ==  P0[s, g] +
                                  qP*nP*P[s-1, g, t] -
                                  P[s, g, t] * (μP*compute_density(densP, sum(L[:, :, t])) + qP*nP))

;

@constraint(model, P_con_B1[s = SP[2:end], g = G, t = T[2:end]] ,
                   P[s, g, t] ==  P[s, g, t-1] +
                                  qP*nP*P[s-1, g, t] -
                                  P[s, g, t] * (μP*compute_density(densP, sum(L[:, :, t])) + qP*nP))

;

# Males

@constraint(model, M_con_0[s = SM, g = G, t = T[1]],
                   M[s, g, t] ==  M0[s, g] +
                                  (1-Φ[g]) * qP * nP * P[end , g ,t] -
                                  μM * M[s, g, t] * compute_density(densM, sum(M[:, :, t])))


;

@constraint(model, M_con_1[s = SM, g = G, t = T[2:end]],
                   M[s, g, t] ==  M[s, g, t-1] +
                                  (1-Φ[g]) * qP * nP * P[end , g ,t] -
                                  μM * M[s, g, t] * compute_density(densM, sum(M[:, :, t])) + control[g, t])
;


@NLconstraint(model, F_con_0[s = SF, g = G, t = T[1]],
            F[s, g, t] == F0[s, g] +
                        (M[1, s, t]*Η[s]/(1e-6 + sum(M[1, i, t]*Η[i] for i in G))*(Φ[g] * qP * nP * P[end, g, t]) -
                         μF * F[s, g, t])) # * compute_density(densF, sum(F[:, :, t])))

# Note difference necessary in S index definition between M terms and F terms + indexing fix addressing transpose of P values (s vs g)
# Re-include compute_density after reformulating so as not to use @NLconstraint
;

@constraint(model, mate_bound[s = SF, t = T], M[1, s, t]*Η[s] <= (1e-6+sum(M[1, i, t]*Η[i] for i in G)))

@NLconstraint(model, F_con_1[s = SF, g = G, t = T[2:end]],
            F[s, g, t] == F[s, g, t-1] +
                        (M[1, s, t]*Η[s]/(1e-6+sum(M[1, i, t]*Η[i] for i in G))*(Φ[g] * qP * nP * P[end, g, t]) -
                         μF * F[s, g, t])) # * compute_density(densF, sum(F[:, :, t])))

# NB:  eps() is unrecognized here, used 0.000001 instead
;


# Control 
@constraint(model, control_limits, sum(control) <= 100)

# No objective function (comment out the control in this case)
# optimize!(model)

# When control is included
#@objective(model, Min, sum((M[:,4,i].data - M[:,1,i].data).^2 + 1e-6 * control[1,i] for i in T))
#@objective(model, Min, sum((M[:,4,i].data - M[:,1,i].data).^2 for i in T))
#@objective(model, Min, sum((M[:,1,i].data + control[1,i]) for i in T))
#@objective(model, Min, sum(control[1,i] for i in T))
@objective(model, Min, (sum(M[:,4,:].data.^2) + 1e-6*sum(control)));

optimize!(model)

println("Objective value: ", objective_value(model))

value.(control)

value.(L)[:, :, end]

value.(P)[:, :, end]

value.(M)[:, :, end]

value.(F)[:, 4, end]

using DataFrames
df = DataFrame()
for (k, v) in model.obj_dict
    if eltype(v) == VariableRef
        if length(axes(v)) == 3
            for g in axes(v)[2]
                col_symbol = Symbol(k,"_G$(g)")
                if occursin("F", String(k))
                    df[!, col_symbol] = sum(value.(v[g,:,:]).data, dims = 1)[1,:]
                    continue
                end
                df[!,col_symbol] = value.(v[end,g,:])
            end
        end
        if length(axes(v)) == 2
            for g in axes(v)[1]
                col_symbol = Symbol(k,"_G$(g)")
                df[!,col_symbol] = value.(v[g,:])
            end
        end
    end
end

for (ix, arr) in eachcol(df, true)
    occursin("M", String(ix)) && plot(arr, label=String(ix))
end
legend(bbox_to_anchor=[1.0,1],loc=2,borderaxespad=0)
