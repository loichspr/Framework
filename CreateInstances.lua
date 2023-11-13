local HttpService = game:GetService('HttpService')
local Module = { }

function Module:GenerateTemplate( name : string, parent : Instance, instanceType : string, Internals : { }?)
	local newInstance = Instance.new(instanceType)

	if Internals then
		for _, interalNew in next, Internals do
			local internalInstance = Instance.new(interalNew.Type)
			internalInstance.Name = interalNew.Name or string.lower(HttpService:GenerateGUID(false))
			internalInstance.Parent = newInstance
			if internalInstance.Value then
				internalInstance.Value = interalNew.Value
			end
		end
	end

	newInstance.Name = name or string.lower(HttpService:GenerateGUID(false))
	newInstance.Parent = parent
	return newInstance
end

return Module