-- MOD MENU BY MAXIME

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local mouse = player:GetMouse()

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ModMenu"
gui.ResetOnSpawn = false

-- Dot (to reopen)
local dot = Instance.new("TextButton", gui)
dot.Size = UDim2.new(0, 25, 0, 25)
dot.Position = UDim2.new(0, 10, 0, 10)
dot.Text = "+"
dot.Font = Enum.Font.SourceSansBold
dot.TextSize = 20
dot.TextColor3 = Color3.new(1, 1, 1)
dot.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dot.Visible = false
dot.AutoButtonColor = true
dot.ZIndex = 10

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 280)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true
frame.ZIndex = 10
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Name = "MainFrame"

-- UI Corner for rounded edges
local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 10)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "MOD MENU BY MAXIME"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BorderSizePixel = 0

-- Helper function to create slider
local function createSlider(parent, name, posY, min, max, default)
	local label = Instance.new("TextLabel", parent)
	label.Size = UDim2.new(0, 120, 0, 25)
	label.Position = UDim2.new(0, 15, 0, posY)
	label.Text = name
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.BackgroundTransparency = 1
	
	local sliderFrame = Instance.new("Frame", parent)
	sliderFrame.Size = UDim2.new(0, 150, 0, 20)
	sliderFrame.Position = UDim2.new(0, 140, 0, posY+3)
	sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	sliderFrame.ClipsDescendants = true
	sliderFrame.Name = name.."Slider"
	local corner = Instance.new("UICorner", sliderFrame)
	corner.CornerRadius = UDim.new(0, 8)
	
	local fill = Instance.new("Frame", sliderFrame)
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	fill.Name = "Fill"
	local fillCorner = Instance.new("UICorner", fill)
	fillCorner.CornerRadius = UDim.new(0, 8)
	
	local thumb = Instance.new("ImageButton", sliderFrame)
	thumb.Size = UDim2.new(0, 18, 0, 20)
	thumb.Position = UDim2.new(fill.Size.X.Scale, 0, 0, 0)
	thumb.BackgroundTransparency = 1
	thumb.Name = "Thumb"
	thumb.Image = "rbxassetid://3570695787" -- small white circle image
	
	local valueLabel = Instance.new("TextLabel", parent)
	valueLabel.Size = UDim2.new(0, 40, 0, 25)
	valueLabel.Position = UDim2.new(0, 295, 0, posY)
	valueLabel.TextColor3 = Color3.new(1,1,1)
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 16
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	
	-- Value update function
	local function updateSlider(inputPosX)
		local relativeX = math.clamp(inputPosX - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
		local scale = relativeX / sliderFrame.AbsoluteSize.X
		fill.Size = UDim2.new(scale, 0, 1, 0)
		thumb.Position = UDim2.new(scale, 0, 0, 0)
		local value = math.floor(min + scale * (max - min))
		valueLabel.Text = tostring(value)
		return value
	end
	
	local dragging = false
	
	thumb.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)
	thumb.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local val = updateSlider(input.Position.X)
			if name == "Walk Speed" then
				humanoid.WalkSpeed = val
			elseif name == "Jump Height" then
				humanoid.JumpPower = val
			end
		end
	end)
	
	-- Initialize values
	humanoid.WalkSpeed = default
	humanoid.JumpPower = default
	
	return sliderFrame, valueLabel
end

-- Create sliders
local walkSlider, walkValue = createSlider(frame, "Walk Speed", 55, 8, 100, 16)
local jumpSlider, jumpValue = createSlider(frame, "Jump Height", 95, 20, 150, 50)

-- Wall Hack Button
local noclip = false
local wallBtn = Instance.new("TextButton", frame)
wallBtn.Size = UDim2.new(0, 270, 0, 30)
wallBtn.Position = UDim2.new(0, 15, 0, 140)
wallBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
wallBtn.TextColor3 = Color3.new(1, 1, 1)
wallBtn.Font = Enum.Font.Gotham
wallBtn.TextSize = 18
wallBtn.Text = "Wall Hack: OFF"
wallBtn.AutoButtonColor = false
local wallCorner = Instance.new("UICorner", wallBtn)
wallCorner.CornerRadius = UDim.new(0, 8)

wallBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	wallBtn.Text = "Wall Hack: " .. (noclip and "ON" or "OFF")
end)

-- Dance Button
local danceBtn = Instance.new("TextButton", frame)
danceBtn.Size = UDim2.new(0, 270, 0, 30)
danceBtn.Position = UDim2.new(0, 15, 0, 185)
danceBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
danceBtn.TextColor3 = Color3.new(1, 1, 1)
danceBtn.Font = Enum.Font.Gotham
danceBtn.TextSize = 18
danceBtn.Text = "Dance"
danceBtn.AutoButtonColor = false
local danceCorner = Instance.new("UICorner", danceBtn)
danceCorner.CornerRadius = UDim.new(0, 8)

-- Corrected dance animation
local danceAnimId = "rbxassetid://507771019"
local danceTrack

danceBtn.MouseButton1Click:Connect(function()
	if not danceTrack then
		local anim = Instance.new("Animation")
		anim.AnimationId = danceAnimId
		danceTrack = humanoid:LoadAnimation(anim)
	end
	if danceTrack.IsPlaying then
		danceTrack:Stop()
		danceBtn.Text = "Dance"
	else
		danceTrack:Play()
		danceBtn.Text = "Stop Dancing"
	end
end)

-- Fly Button
local flying = false
local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0, 270, 0, 30)
flyBtn.Position = UDim2.new(0, 15, 0, 230)
flyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
flyBtn.TextColor3 = Color3.new(1, 1, 1)
flyBtn.Font = Enum.Font.Gotham
flyBtn.TextSize = 18
flyBtn.Text = "Fly: OFF"
flyBtn.AutoButtonColor = false
local flyCorner = Instance.new("UICorner", flyBtn)
flyCorner.CornerRadius = UDim.new(0, 8)

local bodyVelocity
local bodyGyro

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		flyBtn.Text = "Fly: ON"
		if not bodyVelocity then
			bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			bodyVelocity.Velocity = Vector3.new(0, 0, 0)
			bodyVelocity.Parent = char.HumanoidRootPart
		end
		if not bodyGyro then
			bodyGyro = Instance.new("BodyGyro")
			bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
			bodyGyro.CFrame = char.HumanoidRootPart.CFrame
			bodyGyro.Parent = char.HumanoidRootPart
		end
	else
		flyBtn.Text = "Fly: OFF"
		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end
		if bodyGyro then
			bodyGyro:Destroy()
			bodyGyro = nil
		end
	end
end)

-- Fly movement control
RunService.Heartbeat:Connect(function()
	if flying and bodyVelocity and bodyGyro then
		local camCF = workspace.CurrentCamera.CFrame
		local moveVec = Vector3.new(0, 0, 0)
		
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			moveVec = moveVec + camCF.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			moveVec = moveVec - camCF.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			moveVec = moveVec - camCF.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			moveVec = moveVec + camCF.RightVector
		end
		moveVec = moveVec.Unit * 50
		
		if moveVec.Magnitude > 0 then
			bodyVelocity.Velocity = Vector3.new(moveVec.X, 0, moveVec.Z)
			bodyGyro.CFrame = camCF
		else
			bodyVelocity.Velocity = Vector3.new(0, 0, 0)
		end
	end
end)

-- Toggle GUI with dot button
local function toggleGui()
	frame.Visible = not frame.Visible
	dot.Visible = not dot.Visible
end

dot.MouseButton1Click:Connect(toggleGui)

-- Close button in the GUI title
local closeBtn = Instance.new("TextButton", title)
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.AutoButtonColor = false
closeBtn.Name = "CloseButton"
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(toggleGui)

-- Noclip logic (wall hack)
RunService.Stepped:Connect(function()
	if noclip then
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	else
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") and not part.CanCollide then
				part.CanCollide = true
			end
		end
	end
end)

-- Start with default WalkSpeed and JumpPower set
humanoid.WalkSpeed = 16
humanoid.JumpPower = 50
