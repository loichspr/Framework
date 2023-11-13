local rng = Random.new( )

return function(...)

	local entrees = {...}
	local roll
	
	if #entrees < 2 then
		return (entrees[1] and entrees[1][1])
	end
	

	local function Init( )
		local total = 0

		for _, entree in ipairs(entrees) do
			local float = entree[2]
			total = total + float
		end

		for _, entree in ipairs(entrees) do
			local float = entree[2]
			local percentage = (float / total)
			entree[2] = percentage
			entree[3] = float
		end
	end

	local function Roll( )
		roll = rng:NextNumber( )
	end
	
	local function Calc( )
		local total = 0

		for _, entree in ipairs(entrees) do
			local percentage = entree[2]
			total = total + percentage
			if roll <= total then
				return entree
			end
		end
	end

	Init( )
	Roll( )
	local result = Calc( )

	return result[1], roll, result[3]
end