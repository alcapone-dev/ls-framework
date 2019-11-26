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




---------------------------------------------------------------------------
--- Core Functions
---------------------------------------------------------------------------
