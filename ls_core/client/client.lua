--[[[[[[[[[[[[[[[[[[[[[
   START
]]

Citizen.CreateThread(function()
    print('elo')
    TriggerServerEvent("ls:AddPlayerToTable")
    --TriggerServerEvent("DRP_Core:ConnectionSetWeather")
end)

RegisterCommand('print', function(source)

  local source = GetPlayerServerId()
  TriggerServerEvent("debug:printTables", source)


end, false)


---------------------------------------------------------------------------
--- Core Functions
---------------------------------------------------------------------------
