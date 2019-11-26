-- local firstSpawn = true

---------------------------


AddEventHandler('playerSpawned', function()
            print('Player Spawned')
  --[[ if firstSpawn then
            print("first spawn")
            TriggerEvent("DRP_ID:StartSkyCamera")
            Citizen.Wait(1500)
            TriggerServerEvent("DRP_ID:RequestOpenMenu")
            firstSpawn = false
            print("ok")
    end ]]--
end)


------------------------------------------------

--[[
AddEventHandler("onClientMapStart", function()

    for a = 1, 15 do
        EnableDispatchService(a, false)
    end
end)
]]--
