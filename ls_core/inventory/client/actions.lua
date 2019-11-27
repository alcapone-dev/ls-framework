RegisterNUICallback('UseItem', function(data)
    if isWeapon(data.item.id) then
        currentWeaponSlot = data.slot
    end
    print('Close ' .. tostring(data.item.closeUi))
    TriggerServerEvent('inventory:notifyImpendingRemoval', data.item, 1)
    TriggerServerEvent("esx:useItem", data.item.id)
    TriggerEvent('inventory:refreshInventory')
    data.item.msg = 'Item Used'
    data.item.qty = 1
    TriggerEvent('inventory:showItemUse', {
        data.item
    })
end)

local keys = {
    157, 158, 160, 164, 165
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        BlockWeaponWheelThisFrame()
        SetCamEffect(0)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        HideHudComponentThisFrame(17)
        DisableControlAction(0, 37, true) --Disable Tab
        for k, v in pairs(keys) do
            if IsDisabledControlJustReleased(0, v) then
                UseItem(k)
            end
        end
        if IsDisabledControlJustReleased(0, 37) then
            ESX.TriggerServerCallback('inventory:GetItemsInSlotsDisplay', function(items)
                SendNUIMessage({
                    action = 'showActionBar',
                    items = items
                })
            end)
        end
    end
end)

function UseItem(slot)
    ESX.TriggerServerCallback('inventory:UseItemFromSlot', function(item)
        if item then
            if isWeapon(item.id) then
                currentWeaponSlot = slot
            end
            TriggerServerEvent('inventory:notifyImpendingRemoval', item, 1)
            TriggerServerEvent("esx:useItem", item.id)
            item.msg = 'Item Used'
            TriggerEvent('inventory:showItemUse', {
                item,
            })
        end
    end
    , slot)
end

RegisterNetEvent('inventory:showItemUse')
AddEventHandler('inventory:showItemUse', function(items)
    local data = {}
    for k, v in pairs(items) do
        table.insert(data, {
            item = {
                label = v.label,
                itemId = v.id
            },
            qty = v.qty,
            message = v.msg
        })
    end
    print(#data)
    SendNUIMessage({
        action = 'itemUsed',
        alerts = data
    })
end)
