-- MOD MENU by Maxime and Untherneet

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ModMenu"
gui.ResetOnSpawn = false

-- Dot (to reopen)
local dot = Instance.new("TextButton", gui)
dot.Size = UDim2.new(0, 20, 0, 20)
dot.Position = UDim2.new(0, 10, 0, 10)
dot.Text = ""
dot.BackgroundColor3 = Color3.new(1,1,1)
dot.Visible = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 300)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Mod Menu by Maxime and Untherneet"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16

-- Walk Speed
local wsLabel = Instance.new("TextLabel", frame)
wsLabel.Text = "Walk Speed"
wsLabel.Position = UDim2.new(0, 10, 0, 40)
wsLabel.Size = UDim2.new(0, 100, 0, 20)
wsLabel.TextColor3 = Color3.new(1,1,1)
wsLabel.BackgroundTransparency = 1

local wsSlider = Instance.new("TextBox", frame)
wsSlider.Position = UDim2.new(0, 120, 0, 40)
wsSlider.Size = UDim2.new(0, 50, 0, 20)
wsSlider.Text = "16"
wsSlider.BackgroundColor3 = Color3.fromRGB(60,60,60)
wsSlider.TextColor3 = Color3.new(1,1,1)

wsSlider.FocusLost:Connect(function()
	local val = tonumber(wsSlider.Text)
	if val then humanoid.WalkSpeed = val end
end)

-- Jump Power
local jpLabel = wsLabel:Clone()
jpLabel.Text = "Jump Height"
jpLabel.Position = UDim2.new(0, 10, 0, 70)
jpLabel.Parent = frame

local jpSlider = wsSlider:Clone()
jpSlider.Position = UDim2.new(0, 120, 0, 70)
jpSlider.Text = "50"
jpSlider.Parent = frame

jpSlider.FocusLost:Connect(function()
	local val = tonumber(jpSlider.Text)
	if val then humanoid.JumpPower = val end
end)

-- Wall Hack
local noclip = false
local wallBtn = Instance.new("TextButton", frame)
wallBtn.Position = UDim2.new(0, 10, 0, 110)
wallBtn.Size = UDim2.new(0, 160, 0, 25)
wallBtn.Text = "Wall Hack (OFF)"
wallBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
wallBtn.TextColor3 = Color3.new(1,1,1)

wallBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	wallBtn.Text = "Wall Hack (" .. (noclip and "ON" or "OFF") .. ")"
end)

-- Dance
local danceBtn = wallBtn:Clone()
danceBtn.Text = "Dance"
danceBtn.Position = UDim2.new(0, 10, 0, 150)
danceBtn.Parent = frame

danceBtn.MouseButton1Click:Connect(function()
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://507771019" -- Dance 1
	local track = humanoid:LoadAnimation(anim)
	track:Play()
end)

-- Close Button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.new(1,1,1)

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	dot.Visible = true
end)

dot.MouseButton1Click:Connect(function()
	frame.Visible = true
	dot.Visible = false
end)

-- Noclip loop
game:GetService("RunService").Stepped:Connect(function()
	if noclip and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)
