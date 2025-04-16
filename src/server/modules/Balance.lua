local DataStoreService = game:GetService("DataStoreService")
local balanceDataStore = DataStoreService:GetDataStore("PlayerBalances")

local Balance = {}

function Balance.getPlayerBalance(playerId)
    local success, savedBalance = pcall(function()
		return balanceDataStore:GetAsync(playerId)
	end)
	if success and savedBalance then
		print("Retrieved savedBalance: ", savedBalance)
		return savedBalance
	else
		return 0 -- Default balance if no data
	end
end

return Balance