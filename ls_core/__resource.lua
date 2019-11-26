resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'LS Core'

version '1.0.0'

dependencies {
    "externalsql"
}


server_scripts {
	'server/server.lua',
	'server/functions.lua'

}

client_scripts {
	'client/client.lua',
	'client/spawn.lua'

}

server_export "GetPlayerData"
