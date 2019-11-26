Config = {}

Config.OpenControl = 289
Config.TrunkOpenControl = 47
Config.DeleteDropsOnStart = false

Config.Shops = {
    ['My Shop Of Awesome Things'] = {
        coords = {
            vector3(44.38, -1746.76, 29.5),
            vector3(44.38, -1742.76, 29.5),
        },
        items = {
            { name = "bread", price = 100, count = 10 },
            { name = "water", price = 100, count = 10 },
            { name = "disc_ammo_pistol", price = 100, count = 10} ,
            { name = "disc_ammo_pistol_large", price = 1000, count = 10 },
            { name = "WEAPON_SNSPISTOL", price = 100, count = 10 },
        },
        markerType = 1,
        markerColour = { r = 255, g = 255, b = 255 },
        blipColour = 2,
        blipSprite = 52,
        msg = 'Open Shop ~INPUT_CONTEXT~',
        enableBlip = true,
        job = 'all'
    }
}

Config.Stash = {
    ['Police'] = {
        coords = vector3(457.76, -981.05, 30.69),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Police Stash'] = {
        coords = vector3(456.76, -981.05, 30.69),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    }
}

Config.Steal = {
    black_money = true,
    cash = true
}

Config.Seize = {
    black_money = true,
    cash = true
}

--Courtesy DoctorTwitch
Config.VehicleSlot = {
    [0] = 10, --Compact
    [1] = 15, --Sedan
    [2] = 20, --SUV
    [3] = 15, --Coupes
    [4] = 5, --Muscle
    [5] = 5, --Sports Classics
    [6] = 5, --Sports
    [7] = 0, --Super
    [8] = 5, --Motorcycles
    [9] = 10, --Off-road
    [10] = 20, --Industrial
    [11] = 20, --Utility
    [12] = 30, --Vans
    [13] = 0, --Cycles
    [14] = 0, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 20, --Service
    [18] = 20, --Emergency
    [19] = 90, --Military
    [20] = 0, --Commercial
    [21] = 0 --Trains
}