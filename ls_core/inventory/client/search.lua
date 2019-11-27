local secondarySearchInventory = {
    type = 'player',
    owner = '',
    seize = true
}
local secondaryStealInventory = {
    type = 'player',
    owner = '',
    steal = true
}



RegisterNetEvent('inventory:search')
AddEventHandler('inventory:search', function()
    local player = ESX.GetPlayerData()
    if player.job.name == 'police' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local searchPlayerPed = GetPlayerPed(closestPlayer)
            if IsEntityPlayingAnim(searchPlayerPed, 'mp_arresting', 'idle', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 then
                ESX.TriggerServerCallback('inventory:getIdentifier', function(identifier)
                    secondarySearchInventory.owner = identifier
                    openInventory(secondarySearchInventory)
                end, GetPlayerServerId(closestPlayer))
            end
        end
    end
end)

RegisterNetEvent('inventory:steal')
AddEventHandler('inventory:steal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local searchPlayerPed = GetPlayerPed(closestPlayer)
        if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) then
            ESX.TriggerServerCallback('inventory:getIdentifier', function(identifier)
                secondaryStealInventory.owner = identifier
                openInventory(secondaryStealInventory)
            end, GetPlayerServerId(closestPlayer))
        end
    end
end)

RegisterNUICallback('StealCash', function(data)
    TriggerServerEvent('inventory:StealCash', data)
end)
RegisterNUICallback('SeizeCash', function(data)
    TriggerServerEvent('inventory:SeizeCash', data)
end)
