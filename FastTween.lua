return function(_entity, tweenGoals, tweenInfoRaw)

	if type(_entity) ~= "table" then  _entity = {_entity}  end

	local tweens = { }

	for _, entity in ipairs(_entity) do
		if tweenInfoRaw == nil then
			tweenInfoRaw = {
				1,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.Out,
			}
		else
			if tweenInfoRaw[2] == nil then
				tweenInfoRaw[2] = Enum.EasingStyle.Sine

			elseif type(tweenInfoRaw[2]) == "string" then
				tweenInfoRaw[2] = Enum.EasingStyle[tweenInfoRaw[2]]
			end

			if tweenInfoRaw[3] == nil then
				tweenInfoRaw[3] = Enum.EasingDirection.InOut

			elseif type(tweenInfoRaw[3]) == "string" then
				tweenInfoRaw[3] = Enum.EasingDirection[tweenInfoRaw[3]]
			end
		end

		local tweenInfo = TweenInfo.new(unpack(tweenInfoRaw))
		local tweenGoals = tweenGoals
		local tween = game:GetService("TweenService"):Create(entity, tweenInfo, tweenGoals)

		tween:Play( )

		table.insert(tweens, tween)
	end

	return unpack(tweens)
    
end