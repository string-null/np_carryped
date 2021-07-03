Citizen.CreateThread(function()
     print("[^1"..GetCurrentResourceName().."^7] Started!")
     if GetCurrentResourceName() ~= 'np_carryped' then
 		print("[^1"..GetCurrentResourceName().."^7] !!^3WARNING^7!! Please rename the resource from "..GetCurrentResourceName().." to 'np_carryped'")
         Citizen.Wait(2000)
         os.exit()
    end
    end)
    


Citizen.CreateThread(function()
    Citizen.Wait(250)
    SetConvarServerInfo("discord.gg/nonpayer", current_version)
    local resource_name = GetCurrentResourceName()
    local current_version = GetResourceMetadata(resource_name, 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/string-null/Nonpayer_Versions/master/'..resource_name..'.txt',function(error, result, headers)
        local new_version = result:sub(1, -2)
        SetConvarServerInfo("np_carryped [by Juanjo#7253]", current_version)
        if new_version ~= current_version then
            print('^2['..resource_name..'] - New Update Available.^0\nCurrent Version: ^5'..current_version..'^0\nNew Version: ^5'..new_version..'^0')
        end
    end,'GET')
end)
