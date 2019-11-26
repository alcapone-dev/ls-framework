TriggerServerCallback = function(name, cb, ...)
ServerCallbacks[CurrentRequestId] = cb

	TriggerServerEvent('triggerServerCallback', name, CurrentRequestId, ...)

	if CurrentRequestId < 65535 then
		CurrentRequestId = CurrentRequestId + 1
	else
		CurrentRequestId = 0
	end
end
