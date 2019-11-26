resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'LS Core'

version '1.0.0'

dependencies {
    "externalsql"
}


----- core


server_scripts {
	'server/server.lua',
	'server/functions.lua'

}

client_scripts {
	'client/client.lua',
	'client/spawn.lua'

}

server_export "GetPlayerData"




--- inventory

client_scripts {
    'inventory/client/main.lua',
    'inventory/config.lua',
    'inventory/client/actions.lua',
    'inventory/client/inventory.lua',
    'inventory/client/drop.lua',
    'inventory/client/trunk.lua',
    'inventory/client/glovebox.lua',
    'inventory/client/shop.lua',
    'inventory/client/weapons.lua',
    'inventory/client/search.lua',
    'inventory/client/stash.lua',
    'inventory/common/drop.lua',
    'inventory/common/weapons.lua',
    'inventory/utils.lua'
}

server_scripts {
    'inventory/server/drop.lua',
    'inventory/server/main.lua',
    'inventory/config.lua',
    'inventory/server/actions.lua',
    'inventory/server/inventory.lua',
    'inventory/server/player.lua',
    'inventory/server/trunk.lua',
    'inventory/server/glovebox.lua',
    'inventory/server/shop.lua',
    'inventory/server/weapons.lua',
    'inventory/server/search.lua',
    'inventory/server/stash.lua',
    'inventory/server/itemdata.lua',
    'inventory/common/drop.lua',
    'inventory/common/weapons.lua',
    'inventory/utils.lua'
}

files {
    'inventory/html/ui.html',
    'inventory/html/css/style.min.css',
    'inventory/html/js/inventory.js',
    'inventory/html/js/config.js',
    'inventory/html/css/jquery-ui.min.css',
    'inventory/html/css/bootstrap.min.css',
    'inventory/html/js/jquery.min.js',
    'inventory/html/js/jquery-ui.min.js',
    'inventory/html/js/bootstrap.min.js',
    'inventory/html/js/popper.min.js',

    -- IMAGES
    'inventory/html/img/*.png',
    'inventory/html/success.wav',
    'inventory/html/fail.wav',
    -- ICONS

    'inventory/html/img/items/*.png',
}
