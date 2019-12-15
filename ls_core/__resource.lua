resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'LS Core'

version '1.0.0'

dependencies {
    "externalsql"
}


----- core


server_scripts {
  'config.lua',
	'server/server.lua',
	'server/functions.lua',
  'server/items.lua',
  'server/classes/callbacks.lua',
  'server/classes/player.lua'

}

client_scripts {
	'client/client.lua',
	'client/spawn.lua',
  'client/functions.lua'

}

server_export "GetPlayerData"


---- Libs
server_scripts {
  'libs/class.lua'
}


--- inventory
client_scripts {

}

server_scripts {

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
