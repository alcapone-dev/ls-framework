local players = {}


AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)

  local src = source
  local joinTime = os.time()


    --
    -- CHECK PLAYER CONNECT FIRST TIME
    --

    exports["externalsql"]:DBAsyncQuery({
            string = "SELECT `steamID` FROM `accounts` WHERE `steamID` = :steamID",
            data = {
                steamID = PlayerIdentifier("steam", src)
            }
        }, function(results)

      ---
      --- IF PLAYER EXIST
      ---

      if #results['data'] >= 1 then
        print("Gracz " .. PlayerIdentifier("steam", src) .. " jest w bazie")
        exports["externalsql"]:DBAsyncQuery({
                string = "UPDATE `accounts` SET last_login=CURRENT_TIMESTAMP WHERE `steamID` = :steamID",
                data = {
                    steamID = PlayerIdentifier("steam", src)
                }
            })
            return

        --
        -- IF PLAYER NOT EXIST
        --

      else

      exports["externalsql"]:DBAsyncQuery({
              string = "INSERT INTO accounts (steamID) values (:steamID)",
              data = {
                  steamID = PlayerIdentifier("steam", src)
              }
          })
        print("Gracz " .. PlayerIdentifier("steam", src).. " zostal dodany")

      end

          end)


  end)




RegisterServerEvent("ls:AddPlayerToTable")
AddEventHandler("ls:AddPlayerToTable", function()

    local src = source

    exports["externalsql"]:DBAsyncQuery({
              string = "SELECT * FROM `accounts` WHERE `steamID` = :steamID",
              data = {
                  steamID = PlayerIdentifier("steam", src)
              }
          }, function(playerResults)

    local playerid = playerResults.data[1].steamID
	  table.insert(players, {id = src, playerid = playerid})

    end)
end)

--------------------------------
---------GetPlayerData----------
--------------------------------

AddEventHandler("ls:GetPlayerData", function(id, callback)
	for a = 1, #players do
        if players[a].id == id then
			  callback(players[a])
			return
        end
    end
    callback(false)
end)


-----------------------------
------DEBUGS-----------------
-----------------------------

RegisterServerEvent("debug:printTables")
AddEventHandler('debug:printTables', function(source)

 local src = source
 print("Players Table: \t"..json.encode(players).."\n")

end)


----------------------------
-------PLAYER EXIT----------
----------------------------

AddEventHandler("playerDropped", function(reason)

  local src = source
  local playerid = PlayerIdentifier("steam", src)
  local playerName = GetPlayerName(src)

  for i, playerid in pairs(players) do
    table.remove(players, i)
  end

  print('LS-Story > Gracz '..playerName..'(ID:'..src..') wyszedl, powod: '..reason)

end)
