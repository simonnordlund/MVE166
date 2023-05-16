"""
  Construct and returns the model of this assignment.
"""


function build_model(relax_x::Bool = true, relax_z::Bool = true, T::Int = 125)
  #Components - the set of components
  #T - the number of time steps in the model
  #d[1,..,T] - cost of a maintenance occasion
  #c[Components, 1,..,T] - costs of new components
  #U[Components] - lives of new components
  
  m = Model()
  if relax_x
    @variable(m, x[Components,t in 1:T+1,s in 0:(t-1)] >= 0)
  else
    @variable(m, x[Components,t in 1:T+1,s in 0:(t-1)] >= 0, Bin)
  end
  if relax_z
      @variable(m, z[1:T] <= 1)
  else
      @variable(m, z[1:T] <= 1, Bin)
  end
  cost = @objective(m, Min,
    sum(d[t]*z[t] for t in 1:(T)) + sum(costnad(i,t,s) * x[i,t,s] for i in Components, t in 1:(T+1), s in 0:(t-1)))


  newconstraint1 = @constraint(m, [i in Components, t in 1:T],
  sum(x[i,t,s] for s in 0:t-1) <= z[t])

  newconstraint2 = @constraint(m,[t in 1:T, i in Components], sum(x[i,t,0] for t in 1:(T+1)) == 1)
  
  newconstraint3 = @constraint(m, [i in Components, t in 1:T],sum(x[i,t,s] for s in 0:(t-1))==sum(x[i,r,t] for r in (t+1):(T+1)))

  




  return m, x, z
end





