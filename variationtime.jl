using JuMP 
using Gurobi

include("as_dat_large.jl")
include("as_new_mod.jl")

function varytime(T_values)
    runtimes = []
    for i in T_values
        m,x,z = build_model(true,true,i)
        set_optimizer(m,Gurobi.Optimizer)
        set_optimizer_attributes(m, "MIPGap" => 1e-1, "TimeLimit" => 3600)
        optimize!(m)
        runtimes = push!(runtimes, solve_time(m))
    end
    return runtimes
end 

T_values = 50:5:700




runtimes = varytime(T_values)
print(runtimes)