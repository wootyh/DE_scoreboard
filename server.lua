ESX.RegisterServerCallback('DE_scoreboard:getOnlinePlayers', function(source, cb)
    local xPlayers = ESX.GetExtendedPlayers()
    local data = {}

    for _, xPlayer in pairs(xPlayers) do
        table.insert(data, {
            id = xPlayer.source,
            label = '[' .. xPlayer.source .. '] ' .. GetPlayerName(xPlayer.source)
        })
    end
    
    cb(data)
end)