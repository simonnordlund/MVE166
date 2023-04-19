using JuMP 

function our_model(asmnt1_data::String)
    include(asmnt1_data)

    #Empty model
    model = Model()

    #Define decition variables

    @variable(model, sell[prod_I] >= 0)
    @variable(model, alloc[crop_J] >= 0)
    # @variable(model, M >= 0) #What are these? Why do these need to be variables? 
    # @variable(model, S >= 0) #What are these? Why do these need to be variables?

    #These should be able to be calculated throught the amount of product i we produce.

    @objective(model, Max, sum(price_prod[i] * sell[i] * (1-tax_I[i]) for i in prod_I) - sum(perc_I[i]*sell[i] * (0.2/0.9) * 1.5 for i in prod_I) - sum(cost_S * (1-perc_I[i]) * sell[i] for i in prod_I)) 

    #Maximum allocated area
    @constraint(model, sum(alloc[j] for j in crop_J) <= max_A) 

    #Maximum water available
    @constraint(model, sum(alloc[j] * demand_W[j] for j in crop_J) <= max_W) 

    #Biodiesel balance(equality)
    @constraint(model,  sum(0.9 * oil_J[j] * 1000 * yield_J[j] * alloc[j] for j in crop_J)  == sum(perc_I[i] * sell[i] for i in prod_I))

    #Maximum amount of petrol diesel
    @constraint(model, sum((1-perc_I[i]) * sell[i] for i in prod_I) <= max_S)

    #The demand
    @constraint(model, sum(sell[i] for i in prod_I) >= demand)

    return model, sell, alloc
end
