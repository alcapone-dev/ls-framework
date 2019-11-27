X = {}
X.Players = {}
X.UsableItemsCallbacks = {}
X.ServerCallbacks = {}

RegisterServerEvent('triggerServerCallback')
AddEventHandler('triggerServerCallback', function(name, requestId, ...)
	local _source = source

	X.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('serverCallback', _source, requestId, ...)
	end, ...)
end)
