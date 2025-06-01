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
dot.Font = Enum.Font.GothamBold
dot.TextSize = 20
dot.TextColor3 = Color3.new(1, 1, 1)
dot.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
dot.AutoButtonColor = false
dot.Visible = false
dot.ZIndex = 10
local dotCorner = Instance.new("UICorner", dot)
dotCorner.CornerRadius = UDim.new(0, 6)

dot.MouseEnter:Connect(function()
    dot.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
end)
dot.MouseLeave:Connect(function()
    dot.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 300)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 40) -- slightly lighter and cooler
frame.Active = true
frame.Draggable = true
frame.ZIndex = 10
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Name = "MainFrame"
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 12)

-- Shadow (optional)
local shadow = Instance.new("ImageLabel", frame)
shadow.Size = UDim2.new(1, 14, 1, 14)
shadow.Position = UDim2.new(0, -7, 0, -7)
shadow.BackgroundTransparency = 1
shadow.ZIndex = 0
shadow.Image = "rbxassetid://1316045217" -- shadow image
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.7

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
title.Text = "MOD MENU BY MAXIME"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 12)

-- Close button
local closeBtn = Instance.new("TextButton", title)
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.AutoButtonColor = false
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 6)

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
end)

-- Toggle GUI function
local function toggleGui()
	frame.Visible = not frame.Visible
	dot.Visible = not dot.Visible
end
closeBtn.MouseButton1Click:Connect(toggleGui)
dot.MouseButton1Click:Connect(toggleGui)

-- Helper function to create sliders with better spacing
local function createSlider(parent, name, posY, min, max, default)
	local label = Instance.new("TextLabel", parent)
	label.Size = UDim2.new(0, 130, 0, 25)
	label.Position = UDim2.new(0, 15, 0, posY)
	label.Text = name
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.BackgroundTransparency = 1
	
	local sliderFrame = Instance.new("Frame", parent)
	sliderFrame.Size = UDim2.new(0, 150, 0, 20)
	sliderFrame.Position = UDim2.new(0, 150, 0, posY + 3)
	sliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	sliderFrame.ClipsDescendants = true
	sliderFrame.Name = name.."Slider"
	local corner = Instance.new("UICorner", sliderFrame)
	corner.CornerRadius = UDim.new(0, 10)
	
	local fill = Instance.new("Frame", sliderFrame)
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(70, 170, 255)
	fill.Name = "Fill"
	local fillCorner = Instance.new("UICorner", fill)
	fillCorner.CornerRadius = UDim.new(0, 10)
	
	local thumb = Instance.new("ImageButton", sliderFrame)
	thumb.Size = UDim2.new(0, 20, 0, 20)
	thumb.Position = UDim2.new(fill.Size.X.Scale, 0, 0, 0)
	thumb.BackgroundTransparency = 1
	thumb.Name = "Thumb"
	thumb.Image = "rbxassetid://3570695787" -- white circle
	
	local valueLabel = Instance.new("TextLabel", parent)
	valueLabel.Size = UDim2.new(0, 45, 0, 25)
	valueLabel.Position = UDim2.new(0, 305, 0, posY)
	valueLabel.TextColor3 = Color3.new(1,1,1)
	valueLabel.Font = Enum.Font.Gotham
	valueLabel.TextSize = 16
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	
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
	
	-- Set initial values only if sliders are for Walk Speed or Jump Height
	if name == "Walk Speed" then
		humanoid.WalkSpeed = default
	elseif name == "Jump Height" then
		humanoid.JumpPower = default
	end
	
	return sliderFrame, valueLabel
end

-- Create sliders
local walkSlider, walkValue = createSlider(frame, "Walk Speed", 60, 8, 100, 16)
local jumpSlider, jumpValue = createSlider(frame, "Jump Height", 110, 20, 150, 50)

-- Wall Hack Button
local noclip = false
local wallBtn = Instance.new("TextButton", frame)
wallBtn.Size = UDim2.new(0, 300, 0, 35)
wallBtn.Position = UDim2.new(0, 10, 0, 160)
wallBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
wallBtn.TextColor3 = Color3.new(1, 1, 1)
wallBtn.Font = Enum.Font.Gotham
wallBtn.TextSize = 18
wallBtn.Text = "Wall Hack: OFF"
wallBtn.AutoButtonColor = false
local wallCorner = Instance.new("UICorner", wallBtn)
wallCorner.CornerRadius = UDim.new(0, 10)

wallBtn.MouseEnter:Connect(function()
	wallBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
end)
wallBtn.MouseLeave:Connect(function()
	wallBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

wallBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	wallBtn.Text = "Wall Hack: " .. (noclip and "ON" or "OFF")
end)

-- Dance Button
local danceBtn = Instance.new("TextButton", frame)
danceBtn.Size = UDim2.new(0, 300, 0, 35)
danceBtn.Position = UDim2.new(0, 10, 0, 210)
danceBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
danceBtn.TextColor3 = Color3.new(1, 1, 1)
danceBtn.Font = Enum.Font.Gotham
danceBtn.TextSize = 18
danceBtn.Text = "Dance"
danceBtn.AutoButtonColor = false
local danceCorner = Instance.new("UICorner", danceBtn)
danceCorner.CornerRadius = UDim.new(0, 10)

danceBtn.MouseEnter:Connect(function()
	danceBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
end)
danceBtn.MouseLeave:Connect(function()
	danceBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

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
flyBtn.Size = UDim2.new(0, 300, 0, 35)
flyBtn.Position = UDim2.new(0, 10, 0, 260)
flyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
flyBtn.TextColor3 = Color3.new(1, 1, 1)
flyBtn.Font = Enum.Font.Gotham
flyBtn.TextSize = 18
flyBtn.Text = "Fly"
flyBtn.AutoButtonColor = false
local flyCorner = Instance.new("UICorner", flyBtn)
flyCorner.CornerRadius = UDim.new(0, 10)

flyBtn.MouseEnter:Connect(function()
	flyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
end)
flyBtn.MouseLeave:Connect(function()
	flyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

local bodyVelocity

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		flyBtn.Text = "Stop Flying"
		bodyVelocity = Instance.new("BodyVelocity", char.PrimaryPart)
		bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bodyVelocity.Velocity = Vector3.new(0, 0, 0)
		
		RunService:BindToRenderStep("FlyMovement", Enum.RenderPriority.Character.Value + 1, function()
			if flying and bodyVelocity then
				local direction = Vector3.new()
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + workspace.CurrentCamera.CFrame.LookVector end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - workspace.CurrentCamera.CFrame.LookVector end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - workspace.CurrentCamera.CFrame.RightVector end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + workspace.CurrentCamera.CFrame.RightVector end
				direction = Vector3.new(direction.X, 0, direction.Z).Unit * 50
				if direction ~= direction then -- if NaN, fallback
					direction = Vector3.new(0, 0, 0)
				end
				bodyVelocity.Velocity = direction + Vector3.new(0, 0, 0)
			end
		end)
	else
		flyBtn.Text = "Fly"
		RunService:UnbindFromRenderStep("FlyMovement")
		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end
	end
end)

-- Noclip implementation
RunService.Stepped:Connect(function()
	if noclip then
		for _, part in ipairs(char:GetChildren()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	else
		for _, part in ipairs(char:GetChildren()) do
			if part:IsA("BasePart") and not part.CanCollide then
				part.CanCollide = true
			end
		end
	end
end)

-- Initially visible
frame.Visible = true
dot.Visible = false
