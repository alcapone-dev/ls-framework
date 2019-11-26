
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

GetDbResult = function(arg, data)

  for i,result in ipairs(arg) do
    return result[data]
  end
end


function PlayerIdentifier(type, id)
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
