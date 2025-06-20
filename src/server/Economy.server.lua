local ServerScriptService = game:GetService("ServerScriptService")
local Balance = require(ServerScriptService.Server.modules.Balance)


--Kingsman added - lines below
local DataStoreService = game:GetService("DataStoreService")
local balanceDataStore = DataStoreService:GetDataStore("PlayerBalances")
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	-- Create HasCar BoolValue
	local purchased = Instance.new("BoolValue")
	purchased.Name = "HasCar"
	purchased.Value = false
	purchased.Parent = player
	print("Created HasCar for player: " .. player.Name)

end)


--Kingsamn
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Parent = leaderstats

	-- Load saved balance
	coins.Value = Balance.getPlayerBalance(player.UserId)
	
	--print("Adding coin")
	--player.leaderstats.Coins.Value += 1
	
	
	if player.Name == "Kingsman0530" then
		coins.Value = 1000
		print("Set Kingsman0530 balance to 9999 coins")
	end
	if player.Name == "EvilRainbow00" then
		coins.Value = 1000
		print("Set EvilRainbow00 balance to 1000 coins")
	end
	if player.Name == "AtlasKitson" then
		coins.Value = 1000
		print("Set AtlasKitson balance to 1000 coins")
	end
	
end)

-- Test
game.Players.PlayerRemoving:Connect(function(player)
	-- Save balance when player leaves
	local success, errorMessage = pcall(function()
		balanceDataStore:SetAsync(player.UserId, player.leaderstats.Coins.Value)
	end)
	if not success then
		warn("Failed to save balance for " .. player.Name .. ": " .. errorMessage)
	end
end)

-- Handle game shutdown to save all players' data
game:BindToClose(function()
	for _, player in pairs(game.Players:GetPlayers()) do
		local success, errorMessage = pcall(function()
			balanceDataStore:SetAsync("Player_" .. player.UserId, player.leaderstats.Coins.Value)
		end)
		if not success then
			warn("Failed to save balance for " .. player.Name .. ": " .. errorMessage)
		end
	end
	print("Saved all players data. Exiting")
end)