local DataStoreService = game:GetService("DataStoreService")
local balanceDataStore = DataStoreService:GetDataStore("PlayerBalances")

-- Function to delete all keys starting with "Player_"
local function deleteAllPlayerKeys()
	local success, keyList = pcall(function()
		return balanceDataStore:ListKeysAsync("Player_")
	end)
	if success then
		local page = keyList:GetCurrentPage()
		for _, keyInfo in ipairs(page) do
			local key = keyInfo.KeyName
			local deleteSuccess, errorMessage = pcall(function()
				balanceDataStore:RemoveAsync(key)
			end)
			if deleteSuccess then
				print("Deleted key: " .. key)
			else
				warn("Failed to delete key " .. key .. ": " .. errorMessage)
			end
		end

		-- Clear the index
		pcall(function()
			balanceDataStore:RemoveAsync("KeyIndex")
			print("Cleared KeyIndex")
		end)
	else
		warn("Failed to retrieve KeyIndex")
	end
end

-- Run the deletion
-- deleteAllPlayerKeys()