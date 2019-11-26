
InvType = {
    ['unknown'] = { slots = 1, label = 'Unknown' },
}

RegisterServerEvent('inventory:RegisterInventory')
AddEventHandler('inventory:RegisterInventory', function(inventory)
    if inventory.name == nil then
        print('Requires inv name')
        return
    end

    if inventory.slots == nil then
        inventory.slots = 4
    end

    if inventory.getInventory == nil then
        print('Registering Default getInventory')
        inventory.getInventory = function(identifier, cb)
            getInventory(identifier, inventory.name, cb)
        end
    end

    if inventory.applyToInventory == nil then
        print('Registering Default applyToInventory')
        inventory.applyToInventory = function(identifier, f)
            applyToInventory(identifier, inventory.name, f)
        end
    end

    if inventory.saveInventory == nil then
        print('Registering Default saveInventory')
        inventory.saveInventory = function(identifier, toSave)
            if table.length(toSave) > 0 then
                saveInventory(identifier, inventory.name, toSave)
            else
                deleteInventory(identifier, inventory.name)
            end
        end
    end

    if inventory.getDisplayInventory == nil then
        print('Registering Default getDisplayInventory')
        inventory.getDisplayInventory = function(identifier, cb, source)
            getDisplayInventory(identifier, inventory.name, cb, source)
        end
    end

    InvType[inventory.name] = inventory
    loadedInventories[inventory.name] = {}
end)


RegisterCommand('ensureInv', function(source)
    TriggerEvent("ls:GetCharacterData", src, function(results)
    --MySQL.Async.fetchAll('DELETE FROM disc_inventory WHERE data = @data AND owner = @owner',{['@data'] = "null",['@owner'] = owner})
    exports["externalsql"]:DBAsyncQuery({
            string = "DELETE FROM `inventory` WHERE `data` = `data:` AND `owner` = `charid:`",
            data = {
                data = "null",
                owner = results.char_id
            }
        }, function(results) -- Tgiann "Null" Fix
    ensureInventories(source)
  end)
end)
end)

function ensureInventories(source)
    local src = source
    local player = src
    ensurePlayerInventory(player)
    TriggerClientEvent('inventory:refreshInventory', source)
end

RegisterCommand('test', function(source, args, raw)
    local str = 'x123y123z123'
    print(getCoordsFromOwner(str))
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        saveInventories()
    end
end)

--[[
AddEventHandler('esx:playerLoaded', function(data)
    local src = source
    local player = src
    loadInventory(player.identifier, 'player', function()
    end)
end)

AddEventHandler('esx:playerDropped', function(data)
    local player = ESX.GetPlayerFromId(data)
    saveInventory(player.identifier, 'player')
end)
]]--
