ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local markerSize = vector3(1.0, 1.0, 1.0);
local markerColor = { r = 333, g = 333, b = 333, a = 333 };

local markers = {
    vector3(378.2, 6507.5, 28),
    vector3(370.4, 6506.3, 28.4),
    vector3(363.5, 6506.2, 28.5),
    vector3(354.8, 6505.1, 28.5),
    vector3(348.1, 6505.8, 28.8),
    vector3(339.9, 6506, 28.7),
    vector3(330.5, 6506.4, 28.6),
    vector3(322.1, 6505.9, 29.2),
    vector3(321.8, 6516.9, 29.1),
    vector3(330, 6517.2, 29),
    vector3(338.7, 6516.6, 28.9),
    vector3(347.5, 6517, 28.8),
    vector3(355.6, 6516.6, 28.2),
    vector3(362.9, 6516.8, 28.3),
    vector3(370.4, 6517.4, 28.4),
    vector3(377.8, 6517.2, 28.4),
    vector3(369.5, 6531.2, 28.4),
    vector3(361.2, 6530.8, 28.4),
    vector3(353.8, 6530.2, 28.4),
    vector3(345.5, 6530.9, 28.7),
    vector3(339.4, 6530.4, 28.6),
    vector3(328.7, 6530.4, 28.7),
    vector3(321.9, 6530.5, 29.2)
};
  
local picking = false
local picked = false 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for _, position in ipairs(markers) do
            local distance = #(position - pedCoords);

            if distance <= Config.DrawDistance then
                if not picking then
                    ESX.ShowHelpNotification("Nyomj [E]-t a szedéshez")
                    
                    -- DrawMarker(2, markers, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 128, 0, 100, false, true, 2, false, nil, false)

                    DrawMarker (
                        2, 
                        position.x, position.y, position.z, 
                        0.0, 0.0, 0.0, 
                        0.0, 0.0, 0.0, 
                        markerSize.x, markerSize.y, markerSize.z, 
                        markerColor.r, markerColor.g, markerColor.b, markerColor.a, 
                        false, true, 2, false, nil, false)
                    
                end
            end
            
            if IsControlJustReleased(0, 86) then
                if distance <= Config.DrawDistanceAnim and not picking then
                    picking = true;
                    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", -1, "upright" )
                    Citizen.Wait(10000)
                    picking = false;
                    ClearPedTasks(ped)
                    TriggerServerEvent('explore_esx:AddItems')
                end
            end
        end
    end
end)

local sell = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(PlayerPedId())
        local distance = Vdist(pedCoords.x, pedCoords.y, pedCoords.z, vector3(-3275.6, 970.1, 8.3) )

        if distance <= Config.DrawDistanceSell then
            if not sell then
            DrawMarker(2, -3275.6, 970.1, 8.3, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.8, 0.8, 0.8, 0, 128, 0, 100, false, true, 2, false, nil, false) 
            if distance <= Config.DrawDistance then
                ESX.ShowHelpNotification("Nyomj [E]-t az eladáshoz!")
            end
        end
            if IsControlJustReleased(0,86) then
                if distance <= Config.DrawDistanceSell and not  sell then
                    TriggerServerEvent('explore_esx:CheckItem') 
                end
            end
        end
    end
end)



        --blip
        local blips = {
            --blip nev    szin melyik legyen    kordik x,y,z
    {title="Alma szedes" ,colour=5, id=76, x = 378.2, y = 6507.5, z = 28},
    {title="Alma eladas", colour=5, id=76, x = -3275.4, y = 969.4, z = 8.3}
 }
Citizen.CreateThread(function()

   for _, info in pairs(blips) do
     info.blip = AddBlipForCoord(info.x, info.y, info.z)
     SetBlipSprite(info.blip, info.id)
     SetBlipDisplay(info.blip, 2)
     SetBlipScale(info.blip, 0.9)
     SetBlipColour(info.blip, info.colour)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(info.title)
     EndTextCommandSetBlipName(info.blip)
   end
end)