local Signal = { }

local isServer = game:GetService('RunService'):IsServer( )
local events = { }
local funcs = { }

Signal.Fire = function(eventName, ...)
	eventName = string.lower(eventName)
	
	local event = GetEvent(eventName)
	
	if (not isServer) and eventName ~= "core signal fired" then
		Signal.Fire("CORE Signal Fired", eventName)
	end
	
	event:Fire(...)
end

Signal.Fired = function(eventName)
	eventName = string.lower(eventName)
	
	local event = GetEvent(eventName)
	
	return event.Event
end


Signal.Invoke = function(funcName, ...)
	funcName = string.lower(funcName)
	local func = GetFunc(funcName)
	
	if (not isServer) and funcName ~= "core signal fired" then
		Signal.Fire("CORE Signal Fired", funcName)
	end
	
	return func:Invoke(...)
end


Signal.Invoked = function(funcName)
	funcName = string.lower(funcName)
	local func = GetFunc(funcName)
	
	return func
end


Signal.Get = function(eventName)
	eventName = string.lower(eventName)
	
	return GetEvent(eventName)
end


function GetEvent(eventName)

	eventName = string.lower(eventName)
	local event = events[eventName]

	if not event then
		event = Instance.new("BindableEvent")
		event.Name = eventName
		events[eventName] = event
	end
	
	return event
end


function GetFunc(funcName)
	funcName = string.lower(funcName)
	local func = funcs[funcName]
	
	if not func then
		func = Instance.new("BindableFunction")
		func.Name = funcName
		funcs[funcName] = func
	end
	
	return func
end

return Signal