local currentWeapon
local currentWeaponSlot

RegisterNetEvent('inventory:useWeapon')
AddEventHandler('inventory:useWeapon', function(weapon)
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
    currentWeapon = weapon
    GiveWeapon(currentWeapon)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('inventory:removeCurrentWeapon')
AddEventHandler('inventory:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        ClearPedTasks(PlayerPedId())
    end
end)

function RemoveWeapon(weapon)
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    local ammoCount = GetAmmoInPedWeapon(playerPed, hash)
    TriggerServerEvent('inventory:updateAmmoCount', hash, ammoCount)
    RemoveWeaponFromPed(playerPed, hash)
end

function GiveWeapon(weapon)
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    X.TriggerServerCallback('inventory:getAmmoCount', function(ammoCount)
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        SetPedAmmo(playerPed, hash, ammoCount)
    end, hash)
end
