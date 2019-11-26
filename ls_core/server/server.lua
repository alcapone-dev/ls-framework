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


    -- exports['ghmattimysql']:scalar('SELECT steamID FROM accounts WHERE steamID = @steamid', {['@steamid'] = PlayerIdentifier("steam", src) }, function(result)


      ---
      --- IF PLAYER EXIST
      ---

      if #results['data'] >= 1 then
        print("Gracz " .. PlayerIdentifier("steam", src) .. " jest w bazie")
        --exports['ghmattimysql']:scalar('UPDATE accounts set last_login=CURRENT_TIMESTAMP WHERE steamid = @steamid', {['@steamid'] = PlayerIdentifier("steam", src) })
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
      --exports['ghmattimysql']:scalar('INSERT INTO accounts (steamID) values (@steamid)', {['@steamid'] = PlayerIdentifier("steam", src) })
      exports["externalsql"]:DBAsyncQuery({
              string = "INSERT INTO accounts (steamID) values (:steamID)",
              data = {
                  steamID = PlayerIdentifier("steam", src)
              }
          })
        print("Gracz " .. PlayerIdentifier("steam", src).. " zostal dodany")

      end

          end)

     ---
     --- CHECK PLAYER HAVE EMAIL
     ---

     --exports['ghmattimysql']:scalar('SELECT email FROM accounts WHERE steamID = @steamid', {['@steamid'] = PlayerIdentifier("steam", src) }, function(result)
       --print(result)




  end)



RegisterServerEvent("test")
AddEventHandler('test', function(source)

  local src = source

    --exports['ghmattimysql']:execute('SELECT * FROM accounts WHERE steamID = @steamid', {['@steamid'] = PlayerIdentifier("steam", src) }, function(result)



  end)


RegisterServerEvent("ls:AddPlayerToTable")
AddEventHandler("ls:AddPlayerToTable", function()
    print('huj1')

    local src = source

    --exports['ghmattimysql']:execute('SELECT * FROM accounts WHERE steamID = @steamid', {['@steamid'] = PlayerIdentifier("steam", src) }, function(playerResults)
    exports["externalsql"]:DBAsyncQuery({
              string = "SELECT * FROM `accounts` WHERE `steamID` = :steamID",
              data = {
                  steamID = PlayerIdentifier("steam", src)
              }
          }, function(playerResults)

    local playerid = playerResults.data[1].steamID
    print(playerResults.data[1].steamID)


	  table.insert(players, {id = src, playerid = playerid})
    print('huj2')
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

---------------------------------

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end


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
