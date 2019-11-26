

function GetPlayers()
    local players = {}
    for a = 0, 40 do
        if NetworkIsPlayerActive(a) then
            table.insert(players, a)
        end
    end
    return players
end



GetPlayerData = function(id)
    for a = 1, #players do
        if players[a].id == id then
            return players[a]
        end
    end
    return false
end


PlayerIdentifier = function(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end

---------------------------------------

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




------ Zwraca ID wszystkich postacie dla danego konta

GetPlayerCharacters = function(src)

    local source = src

    exports["externalsql"]:DBAsyncQuery({
              string = "SELECT `id` FROM `characters` WHERE `account_id` = :account_id",
              data = {
                  account_id = PlayerIdentifier("steam", src)
              }
          }, function(playerCharacters)

            return playerCharacters.data[1].id



          end)
end

--- Zwraca ID aktywnej postaci dla source

GetActiveCharacter = function(src)

  for a = 1, #characters do
  if characters[a].id == src then
    return characters[a].id
  end
end
end

------------------------------------

---------------------------
--------Items logic--------
---------------------------
--[[
GetPlayerItems = function(src)

  local source = src
  local activeCharacter = GetActiveCharacter(src)

  if src = activeCharacter then
  exports["externalsql"]:DBAsyncQuery({
            string = "SELECT * FROM `inventory` WHERE `account_id` = :account_id",
            data = {
                account_id = PlayerIdentifier("steam", src)
            }
        }, function(player)

          print(json.encode(player.data))
          if player.data ~= nil then
          return json.encode(player.data)
      else
        return false
      end

    end)
  end
  end
  ]]--


---------------------------------
-------------DEBUGS--------------
---------------------------------
RegisterServerEvent("ls:debugCharacters")
AddEventHandler("ls:debugCharacters", function(source)

  table.insert(characters, {id = 2, account_id = "steam:231123123", character_id = "7"})
end)

---------------------------------

--[[

  function GivePlayerItem(source, item, amount)

    local source = src

    exports["externalsql"]:DBAsyncQuery({
              string = "INSERT ",
              data = {
                  steamID = PlayerIdentifier("steam", src)
              }
          }, function(player)
          end)
        end

]]--


--------------------------------
---------CALLBACKS--------------
--------------------------------

RegisterServerCallback = function(name, cb)
	ServerCallbacks[name] = cb
end

TriggerServerCallback = function(name, requestId, source, cb, ...)
	if ServerCallbacks[name] ~= nil then
		ServerCallbacks[name](source, cb, ...)
	else
		print('TriggerServerCallback => [' .. name .. '] does not exist')
	end
end
