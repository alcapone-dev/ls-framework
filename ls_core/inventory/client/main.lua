RegisterNetEvent('playerLoaded')
AddEventHandler('playerLoaded', function()
    TriggerEvent('inventory:refreshInventory')
end)


local dropSecondaryInventory = {
    type = 'drop',
    owner = 'x123y123z123'
}

local isInInventory = false

RegisterNUICallback('NUIFocusOff', function(data)
    closeInventory()
end)

RegisterCommand('closeinv', function(source, args, raw)
    closeInventory()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
            local _, floorZ = GetGroundZFor_3dCoord(x, y, z)
            dropSecondaryInventory.owner = getOwnerFromCoords(vector3(x, y, floorZ))
            openInventory(dropSecondaryInventory)
        end
    end
end
)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeInventory()
    end
end)
