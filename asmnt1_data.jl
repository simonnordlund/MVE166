crop_J = 1:3  # Types of crops
prod_I = 1:3  # Types of products
slack = 1:4   # Slack variables

#Labels
crop = ["Soybeans" "Sunflower seeds" "Cotton seeds"]
prod = ["B5" "B30" "B100"]

#Crop information
price_prod = [1.43 1.29 1.16] #

yield_J = [2.6 1.4 0.9] #

demand_W = [5.0 4.2 1.0] #Water demand for each crop

oil_J = [0.178 0.216 0.433] #

perc_I = [0.05 0.3 1] #

tax_I = [0.2 0.05 0] # 

cost_M = 1.5

cost_S = 1

max_W = 5000 #Unit Megaliters

demand = 280000 #Unit Liters

max_A = 1600

max_S = 150000 #Unit Liters




