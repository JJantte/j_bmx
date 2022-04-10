RegisterCommand("bmx", function(source, args)
    local vehicleName = args[1] or "bmx"

    -- tarkistaa onko auto olemassa
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = {'Autoa ei tunnistettu: ' .. vehiclename}
        })
        return
    end

    -- lataa auto
    RequestModel(vehicleName)

    -- odota että auto lataa
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    -- pelaajan posiitio mihin auto spawnaa
    local playerPed = PlayerPedId() -- valitsee pedin
    local pos = GetEntityCoords(playerPed) -- ottaa koordinaatit pelaajan pedistä

    -- auton luonti
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    -- aseta pelaajan pedi autoon kuskiksi
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- paskaa
    SetEntityAsNoLongerNeeded(vehicle)

    -- paskaa2
    SetModelAsNoLongerNeeded(vehicleName)

    -- kertoo pelaajalle
    TriggerEvent('chat:addMessage', {
        args = {'Spawnasit ' .. vehicleName .. '.'}
    })
end, false)

RegisterCommand("poistauto", function()
    -- kerää pelaajan pedin
    local playerPed = PlayerPedId()
    -- kerää missä autossa pelaaja on
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    -- poista se AUTO
    DeleteEntity(vehicle)
end, false)