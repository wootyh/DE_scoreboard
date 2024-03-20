----------------------------------------------------------------------
-- Functions
----------------------------------------------------------------------
local HexIdToSteamId = function(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
    local steam64 = math.floor(tonumber(string.sub( cid, 2)))
    local a = steam64 % 2 == 0 and 0 or 1
    local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
    local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end
----------------------------------------------------------------------
-- Callbacks
----------------------------------------------------------------------
if Shared.Core == 'esx' then
    ESX.RegisterServerCallback('DE_scoreboard:getOnlinePlayers', function(source, cb)
        local xPlayers = ESX.GetExtendedPlayers()
        local data = {}
    
        if Config.Identifier then
            for _, xPlayer in pairs(xPlayers) do
                table.insert(data, {
                    id = xPlayer.source,
                    label = '[' .. xPlayer.source .. '] ' .. HexIdToSteamId(xPlayer.getIdentifier())
                })
            end
        else
            for _, xPlayer in pairs(xPlayers) do
                table.insert(data, {
                    id = xPlayer.source,
                    label = '[' .. xPlayer.source .. '] ' .. GetPlayerName(xPlayer.source)
                })
            end
        end        
        cb(data)
    end)
elseif Shared.Core == 'qb' then
    QBCore.Functions.CreateCallback('DE_scoreboard:getOnlinePlayers', function(source, cb)
        local Player = QBCore.Functions.GetPlayer(source)
        local data = {}
    
        for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
            table.insert(data, {
                id = Player.PlayerData.source,
                label = '[' .. Player.PlayerData.source .. '] ' .. GetPlayerName(Player.PlayerData.source)
            })
        end
        cb(data)
    end)
end
