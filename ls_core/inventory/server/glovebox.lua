Citizen.CreateThread(function()
    TriggerEvent('inventory:RegisterInventory', {
        name = 'glovebox',
        label = 'Glove Box',
        slots = 5
    })
end)
