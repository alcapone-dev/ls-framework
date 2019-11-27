secondInventory = nil

RegisterNUICallback('MoveToEmpty', function(data, cb)
    TriggerServerEvent('inventory:MoveToEmpty', data)
    TriggerEvent('inventory:MoveToEmpty', data)
    cb('OK')
end)

RegisterNUICallback('EmptySplitStack', function(data, cb)
    TriggerServerEvent('inventory:EmptySplitStack', data)
    TriggerEvent('inventory:EmptySplitStack', data)
    cb('OK')
end)

RegisterNUICallback('SplitStack', function(data, cb)
    TriggerServerEvent('inventory:SplitStack', data)
    TriggerEvent('inventory:SplitStack', data)
    cb('OK')
end)

RegisterNUICallback('CombineStack', function(data, cb)
    TriggerServerEvent('inventory:CombineStack', data)
    TriggerEvent('inventory:CombineStack', data)
    cb('OK')
end)

RegisterNUICallback('SwapItems', function(data, cb)
    TriggerServerEvent('inventory:SwapItems', data)
    TriggerEvent('inventory:SwapItems', data)
    cb('OK')
end)

RegisterNUICallback('GiveItem', function(data, cb)
    TriggerServerEvent('inventory:GiveItem', data)
    cb('OK')
end)

RegisterNUICallback('GiveCash', function(data, cb)
    TriggerServerEvent('inventory:GiveCash', data)
    cb('OK')
end)

RegisterNUICallback('GetNearPlayers', function(data)

    if data.action == 'give' then
        SendNUIMessage({
            action = "nearPlayersGive",
            players = GetNeareastPlayers(),
            item = data.item
        })
    end

    if data.action == 'pay' then
        SendNUIMessage({
            action = "nearPlayersPay",
            players = GetNeareastPlayers(),
            item = data.item
        })
    end
end)

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = GetPlayersInArea(GetEntityCoords(playerPed), 2.0)

    local players_clean = {}
    local found_players = false

    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            found_players = true
            table.insert(players_clean, { name = GetPlayerName(players[i]), id = GetPlayerServerId(players[i]) })
        end
    end
    return players_clean
end

RegisterNetEvent('inventory:refreshInventory')
AddEventHandler('inventory:refreshInventory', function()
    Citizen.Wait(250)
    refreshPlayerInventory()
    if secondInventory ~= nil then
        refreshSecondaryInventory()
    end
    SendNUIMessage({
        action = "unlock"
    })
end)

function refreshPlayerInventory()
    TriggerServerCallback('inventory:getPlayerInventory', function(data)
        SendNUIMessage(
                { action = "setItems",
                  itemList = data.inventory,
                  invOwner = data.invId,
                  invTier = data.invTier,
                  money = {
                      cash = data.cash,
                      bank = data.bank,
                      black_money = data.black_money
                  }
                }
        )
        TriggerServerEvent('inventory:openInventory', {
            type = 'player',
            owner = PlayerIdentifier("steam", src)
        })
    end, 'player', 
end

function refreshSecondaryInventory()
    TriggerServerCallback('inventory:getSecondaryInventory', function(data)
        SendNUIMessage(
                { action = "setSecondInventoryItems",
                  itemList = data.inventory,
                  invOwner = data.invId,
                  invTier = data.invTier,
                }
        )
        TriggerServerEvent('inventory:openInventory', secondInventory)
    end, secondInventory.type, secondInventory.owner)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage({ action = "hide" })
    SetNuiFocus(false, false)
    TriggerServerEvent('inventory:closeInventory', {
        type = 'player',
        owner = PlayerIdentifier("steam", src)
    })
    if secondInventory ~= nil then
        TriggerServerEvent('inventory:closeInventory', secondInventory)
    end
end

RegisterNetEvent('inventory:openInventory')
AddEventHandler('inventory:openInventory', function(sI)
    openInventory(sI)
end)

function openInventory(_secondInventory)
    isInInventory = true
    refreshPlayerInventory()
    SendNUIMessage({
        action = "display",
        type = "normal"
    })
    if _secondInventory ~= nil then
        secondInventory = _secondInventory
        refreshSecondaryInventory()
        SendNUIMessage({
            action = "display",
            type = 'secondary'
        })
        if _secondInventory.seize then
            SendNUIMessage({
                action = "showSeize"
            })
        end
        if _secondInventory.steal then
            SendNUIMessage({
                action = "showSteal"
            })
        end
    end
    SetNuiFocus(true, true)
end

RegisterNetEvent("inventory:MoveToEmpty")
AddEventHandler("inventory:MoveToEmpty", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("inventory:EmptySplitStack")
AddEventHandler("inventory:EmptySplitStack", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("inventory:SplitStack")
AddEventHandler("inventory:SplitStack", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("inventory:CombineStack")
AddEventHandler("inventory:CombineStack", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("inventory:SwapItems")
AddEventHandler("inventory:SwapItems", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

function playPickupOrDropAnimation(data)
    if data.originTier.name == 'drop' or data.destinationTier.name == 'drop' then
        local playerPed = GetPlayerPed(-1)
        if not IsEntityPlayingAnim(playerPed, 'random@domestic', 'pickup_low', 3) then
            Streaming.RequestAnimDict('random@domestic', function()
                TaskPlayAnim(playerPed, 'random@domestic', 'pickup_low', 8.0, -8, -1, 48, 0, 0, 0, 0)
            end)
        end
    end
end

function playStealOrSearchAnimation(data)
    if data.originTier.name == 'player' and data.destinationTier.name == 'player' then
        local playerPed = GetPlayerPed(-1)
        if not IsEntityPlayingAnim(playerPed, 'random@mugging4', 'agitated_loop_a', 3) then
            Streaming.RequestAnimDict('random@mugging4', function()
                TaskPlayAnim(playerPed, 'random@mugging4', 'agitated_loop_a', 8.0, -8, -1, 48, 0, 0, 0, 0)
            end)
        end
    end
end
