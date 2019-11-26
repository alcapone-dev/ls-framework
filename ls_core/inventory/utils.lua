function math.round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function table.length(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end