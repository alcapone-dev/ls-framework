RegisterServerEvent("core:Player:Joined")
RegisterServerEvent("core:Player:GetCharacters")
RegisterServerEvent("core:Player:SelectedCharacter")



--local players = {}
characters = {}


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





AddEventHandler("core:Player:Joined", function()
    local src = source
    exports["externalsql"]:DBAsyncQuery({
              string = "SELECT * FROM `accounts` WHERE `steamID` = :steamID",
              data = {
                  steamID = PlayerIdentifier("steam", src)
              }
          }, function(results)
            print("mysql > "..json.encode(results))
    Player:LoggedIn(src, results.data[1].steamID)
          end)

    exports["externalsql"]:DBAsyncQuery({
      string = "SELECT id FROM `characters` WHERE `account_id` = :steamID",
      data = {
          steamID = PlayerIdentifier("steam", source)
      }
    }, function(results)
      local characters = results.data
      Player:SetCharacters(source, characters)
    
    
    end)

end)
--[[
AddEventHandler("core:Player:GetCharacters", function(source)

exports["externalsql"]:DBAsyncQuery({
  string = "SELECT id FROM `characters` WHERE `account_id` = :steamID",
  data = {
      steamID = PlayerIdentifier("steam", source)
  }
}, function(results)
  local characters = results.data
  Player:SetCharacters(source, characters)


end)

end)
]]--


AddEventHandler("core:Player:SelectedCharacter", function()

  local src = source

  exports["externalsql"]:DBAsyncQuery({
            string = "SELECT * FROM `characters` WHERE `account_id` = :steamID",
            data = {
                steamID = PlayerIdentifier("steam", src)
            }
        }, function(character)
          print("mysql > "..json.encode(character))

      --table.insert(characters, {id = src, account_id = character.data[1].account_id, character_id = character.data[1].id})


    end)
  end)

-----------------------------
------DEBUGS-----------------
-----------------------------

RegisterServerEvent("debug:printTables")
AddEventHandler('debug:printTables', function(source)

  local src = source
  print(json.encode(Players))
  print(json.encode(Characters))

end)


----------------------------
-------PLAYER EXIT----------
----------------------------

AddEventHandler("playerDropped", function(reason)
  Player:LoggedOut(source)
end)


RegisterServerEvent("client:GetSource")
AddEventHandler('client:GetSource', function(source)
  print('penis')
  print(Player:GetSource(source))
  print(Player:GetSteamID(source))
  print(json.encode(Player:GetCharacters(source)))
end)
