--[[[[[[[[[[[[[[[[[[[[[
   START
]]

Citizen.CreateThread(function()
    print('elo')
    TriggerServerEvent("ls:AddPlayerToTable")
    TriggerServerEvent("ls:AddPlayerCharacterToTable")
    --TriggerServerEvent("DRP_Core:ConnectionSetWeather")
end)


RegisterCommand('print', function(source)

  local source = GetPlayerServerId()
  TriggerServerEvent("debug:printTables", source)


end, false)

RegisterCommand('cb', function(source)

  TriggerServerEvent("ls:GetCharacterData", function(source, callback)
  print(characters[a].id )

  end)
  end, false)

RegisterCommand('fff', function(source)

    local source = GetPlayerServerId()
    print('gowno')
    TriggerServerEvent("ls:debugCharacters", source)

end, false)

RegisterCommand('playerdata', function(source)

    local source = GetPlayerServerId()
    TriggerServerEvent("client:PlayerData", source)

end, false)



RegisterNetEvent("DRP_ID:LoadSelectedCharacter")
AddEventHandler("DRP_ID:LoadSelectedCharacter", function(ped, spawn, spawnInHotel)
	characterSpawnedIn = true
	exports["spawnmanager"]:spawnPlayer({x = spawn[1], y = spawn[2], z = spawn[3], heading = 0.0, model = ped})
	Citizen.Wait(4000)
	local ped = GetPlayerPed(PlayerId())
end)


---------------------------------------------------------------------------
--- Core Functions
---------------------------------------------------------------------------
