local Players = game:GetService("Players")

-- Player attributes defined in server is replicated to all clients
-- Each client can modify their own attributes but these changes will NOT be reflected on the server and all other clients
Players.PlayerAdded:Connect(function(player)
	player:SetAttribute("IsStoreOpened", false)
end)