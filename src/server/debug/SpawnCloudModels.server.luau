local InsertService = game:GetService("InsertService")

local function spawnModelAtPoint(assetId, spawnPoint)
	-- Load the model (yields until loaded)
	local model = InsertService:LoadAsset(assetId):GetChildren()[1]
	model.Parent = workspace

	-- Check if spawnPoint exists and is a BasePart
	if not spawnPoint or not spawnPoint:IsA("BasePart") then
		warn("Invalid spawn point! Model placed at origin.")
		return model
	end

	-- Modern way (Roblox 2022+): Use PivotTo for ALL model types
	if model:IsA("Model") then
		-- Calculate vertical offset (so model doesn't sink into the ground)
		local size = model:GetExtentsSize()
		local offsetY = size.Y / 2

		-- Position the model on the spawn point
		model:PivotTo(spawnPoint.CFrame * CFrame.new(0, offsetY, 0))
	else
		-- Fallback for single parts/unions (non-model objects)
		model.CFrame = spawnPoint.CFrame
	end

	return model
end

-- Find or create a spawn point (e.g., a Part named "SpawnPoint")
local spawnPoint = workspace:FindFirstChild("SpawnLocation") or Instance.new("Part")
spawnPoint.Name = "SpawnLocation"
spawnPoint.Anchored = true
-- spawnPoint.Position = Vector3.new(0, 0, 0)  -- Example position
spawnPoint.Parent = workspace

-- Spawn the model asynchronously
local assetId = 135669038098194  -- Replace with your asset ID
spawn(function()
	-- local model = spawnModelAtPoint(assetId, spawnPoint)
	-- print("Spawned model:", model.Name)
end)