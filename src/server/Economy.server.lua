local ServerScriptService = game:GetService("ServerScriptService")
local Balance = require(ServerScriptService.Server.modules.Balance)

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