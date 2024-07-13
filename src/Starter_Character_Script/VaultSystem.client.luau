local player = game:GetService("Players").LocalPlayer
local playerCharacter = player.Character or player.CharacterAdded:Wait()

local charRoot = playerCharacter:WaitForChild("HumanoidRootPart")
local charHumanoid = playerCharacter:WaitForChild("Humanoid")

local animClimb = charHumanoid:LoadAnimation(script:WaitForChild("ClimbAnim"))

local UIS = game:GetService("UserInputService")

local ledgeAvaliable = true
local vaultAvaliable = true

while game:GetService("RunService").RenderStepped:Wait() do
	local r = Ray.new(charRoot.Position, charRoot.CFrame.LookVector * 7 + charRoot.CFrame.UpVector * -5)
	local part = workspace:FindPartOnRay(r,playerCharacter)

	if part and ledgeAvaliable then
		if part.Name == "Vault" then
			if charHumanoid.FloorMaterial ~= Enum.Material.Air then
				ledgeAvaliable = false
				local Vel = Instance.new("BodyVelocity")
				Vel.Parent = charRoot
				Vel.Velocity = Vector3.new(0,0,0)
				Vel.MaxForce = Vector3.new(1,1,1) * math.huge
				Vel.Velocity = charRoot.CFrame.LookVector * 20 + Vector3.new(0,30,0)
				animClimb:Play()
				game.Debris:AddItem(Vel, .15)
				wait(0.75)
				animClimb:Stop()
				ledgeAvaliable = true
			end
		end
	end
end