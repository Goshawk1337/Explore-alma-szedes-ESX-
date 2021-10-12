ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('explore_esx:AddItems')
AddEventHandler('explore_esx:AddItems', function(item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.addInventoryItem('alma', math.random(1, 7))
end)

local pricePerCount = 10;

RegisterServerEvent('explore_esx:CheckItem')
AddEventHandler('explore_esx:CheckItem', function()
    local xPlayer = ESX.GetPlayerFromId(source);
    if (xPlayer) then
        local count = xPlayer.getInventoryItem('alma').count;
        if (count and count > 0) then 
          xPlayer.addMoney(count * pricePerCount);
          xPlayer.removeInventoryItem('alma', count); 
        end
    end
end)

--[[RegisterServerEvent('explore_esx:RemoveItem')
AddEventHandler('explore_esx:RemoveItem', function(item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('alma', 1)
end)]]

--[[RegisterServerEvent('explore_esx:AddMoney')
AddEventHandler('explore_esx:AddMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(1337)
end)]]--