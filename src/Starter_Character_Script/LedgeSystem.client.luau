local player = game:GetService("Players").LocalPlayer
local playerCharacter = player.Character or player.CharacterAdded:Wait()

local charRoot = playerCharacter:WaitForChild("HumanoidRootPart")
local charHead = playerCharacter:WaitForChild("Head")
local charHumanoid = playerCharacter:WaitForChild("Humanoid")

local animClimb = charHumanoid:LoadAnimation(script:WaitForChild("ClimbAnim"))
local animHold = charHumanoid:LoadAnimation(script:WaitForChild("HoldAnim"))

local touchGUI = player:WaitForChild("PlayerGui"):FindFirstChild("TouchGui")

local UIS = game:GetService("UserInputService")

local ledgeAvaliable = true
local isHolding = false

while game:GetService("RunService").Heartbeat:Wait() do
    local r = Ray.new(charHead.CFrame.p, charHead.CFrame.LookVector * 5)
    local part, position = workspace:FindPartOnRay(r, playerCharacter)

    if part and ledgeAvaliable and not isHolding then
        if part.Size.Y >= 7 then
            if charHead.Position.Y >= (part.Position.Y + (part.Size.Y/2)) - 1 and charHead.Position.Y <=part.Position.Y + (part.Size.Y/2) and charRoot.Velocity.Y <= 0 then
                charRoot.Anchored = true isHolding = animHold:Play() ledgeAvaliable = false
            end
        end
    end
end

function climb()
    local Velo = Instance.new("BodyVelocity", charRoot)
    charRoot.Anchored = false
    Velo.MaxForce = Vector3.new(1,1,1) * math.huge
    Velo.Velocity = charRoot.CFrame.LookVector * 10 + Vector3.new(0, 30, 0)
    animHold:Stop() animClimb:Play()
    game.Debris:AddItem(Velo,.15)
    isHolding = false
    wait(.75)
    ledgeAvaliable = true
end

