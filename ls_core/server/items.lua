item = {}

item = {
  Phone = {id = 1, description = "Ah Shit! Here we go again", image = "phone.png", weight = 1, closeoneuse = 1},
  Dildo = {id = 2, description = "For your mummy!", image = "dildo.png", weight = 1, closeoneuse = 1 }
}





------- kaska

Cash = 2
Price = 1



function removeCash(v)
  if Cash >= v then
    Cash = Cash - v
    return true
else return false
end
end
