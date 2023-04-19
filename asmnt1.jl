using Gurobi
using Clp
using JuMP

#Import data and model
include("asmnt1_data.jl")
include("asmnt1_mod.jl")

model, sell, alloc = our_model("asmnt1_data.jl")

#Choose the solver
set_optimizer(model, Gurobi.Optimizer)

optimize!(model)

println("z = ", objective_value(model))
println("Amount of products sold ", value.(sell.data))
println("Allocated area is ", value.(alloc.data))

