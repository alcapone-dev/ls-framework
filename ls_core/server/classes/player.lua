--------------------------------------------------------------------
-------------------------------Libs---------------------------------
--------------------------------------------------------------------

unpack = function(t, i)
		 i = i or 1
		 if t[i] ~= nil then
			 return t[i], unpack(t, i + 1)
		 end
	 end


function class(...)
    -- "cls" is the new class (not the instance, the actual class table / class metadata)
    local cls, bases = {}, {...}

    cls.__class_instance = true

    -- copy base class contents into the new class
    --print("-------------------------------------------------")
    --print("base stuff:")
    for i, base in ipairs(bases) do
        -- base is a table
        for name, value in pairs(base) do
            cls[name] = value
        end
    end

    -- set the class's __index, and start filling an "is_a" table that contains this class and all of its bases
    -- so you can do an "instance of" check using my_instance.is_a[MyClass]
    cls.__index, cls.is_a = cls, {[cls] = true}
    for i, base in ipairs(bases) do
        for c in pairs(base.is_a) do
            cls.is_a[c] = true
        end
        cls.is_a[base] = true
    end

    -- the class's __call metamethod (when you are actually creating the instance)
    setmetatable(cls, {__call = function (c, ...)
        local instance = setmetatable({}, c)
        -- run the init method if it's there
        local init = instance.__init

        if init then
            generate_init_function(instance, args)()
    end

        return instance
    end})

    -- return the new class table, that's ready to be filled with methods
    return cls
end

-- returns a function that runs a class instance init
function generate_init_function(class_instance, args)
    return
    function()
        class_instance.__init(class_instance, unpack(args))
    end
end


--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------


Players = {}
Characters = {}

Player = class()
	function Player.__init()
		self.source = source
		self.id = id
		self.steamID = steamID
		self.permission = permission
		self.banned = banned
		self.ban_time = ban_time
		self.last_ip = last_ip
		self.last_login = last_login
		self.created_at = created_at
		self.updated_at = updated_at
		self.characters = characters
		print('works')
	end

function Player:GetSource(source)
    return self.source
end

function Player:GetSteamID(source)
	return self.steamID
end

function Player:IsBanned(source)
	return self.banned
end

function Player:LoggedIn(source, steamID)
	self.source = source
	self.steamID = steamID
	table.insert(Players, {source = self.source, steamID = self.steamID})
end

function Player:LoggedOut(source)
		self.source = source
		table.remove(Players, self.source)
		print(json.encode(Players))
end

-------------------------
----TO DO Characters-----
-------------------------

Character = class()
	function Character.__init()


	end
