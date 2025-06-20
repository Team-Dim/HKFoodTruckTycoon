local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    local isStoreOpened = Instance.new("BoolValue")
	isStoreOpened.Name = "IsStoreOpened"
	isStoreOpened.Value = false
	isStoreOpened.Parent = player
end)