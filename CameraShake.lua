local Shake = {}

local rng = Random.new()

local shakeId = 0

Shake.Create = function(length, strength, smoothness, fadeIn)

	if workspace.Camera.CameraType == Enum.CameraType.Scriptable then
		return
	end

	shakeId = shakeId + 1
	length = length or 1
	strength = strength or 1
	smoothness = smoothness or 0
	fadeIn = fadeIn ~= nil and fadeIn or false

	coroutine.wrap(function()
		local localShakeId = shakeId
		local startTick = tick()
		local cameraOffset
		local lastTickIncrement = tick()

		while (shakeId == localShakeId and (tick() - startTick) <= length) do
			local timeFloat = (tick() - startTick) / length

			if not cameraOffset or tick() - lastTickIncrement >= (smoothness / 10) then
				lastTickIncrement = tick()
				local timeSine = (fadeIn and math.sin(timeFloat * math.pi) or math.sin((0.5 + (timeFloat / 2)) * math.pi))

				local x = rng:NextNumber(-timeSine, timeSine) * timeSine * strength
				local y = rng:NextNumber(-timeSine, timeSine) * timeSine * strength
				local z = rng:NextNumber(-timeSine, timeSine) * timeSine * strength

				cameraOffset = Vector3.new(x, y, z)		

				if game:GetService("HapticService"):IsVibrationSupported(Enum.UserInputType.Gamepad1) then
					local shakingAlpha = math.min(strength, 1) * timeSine
					game:GetService("HapticService"):SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, shakingAlpha)
				end
			end
			
			game.Players.LocalPlayer.Character.Humanoid.CameraOffset = game.Players.LocalPlayer.Character.Humanoid.CameraOffset:Lerp(cameraOffset, (1 - smoothness))
			game:GetService("RunService").RenderStepped:Wait()
		end
		
		game.Players.LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
		
		if game:GetService("HapticService"):IsVibrationSupported(Enum.UserInputType.Gamepad1) then
			game:GetService("HapticService"):SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0)
		end
	end)()
end

return Shake