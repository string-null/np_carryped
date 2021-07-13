

function hacerAnim(anim)
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
     Citizen.Wait(5)
    end
   end

   function cogerNPC()
    local jugadorCoord = GetEntityCoords(PlayerPedId())
    local handle, ped = FindFirstPed()
    local rped = nil
    local distancieDe
    repeat
     local pos = GetEntityCoords(ped)
     local distance = GetDistanceBetweenCoords(jugadorCoord, pos, true)
     if canPedBeUsed(ped) and distance < 3.0 and (distancieDe == nil or distance < distancieDe) then
      distancieDe = distance
      rped = ped
      SetEntityAsMissionEntity(rped, true, true)
     end
     np_carryped, ped = FindNextPed(handle)
     until not np_carryped
     EndFindPed(handle)
    return rped
   end

   function canPedBeUsed(ped)
    if ped == nil then return false end
    if ped == PlayerPedId() then return false end
    if not DoesEntityExist(ped) then return false end
    if not IsPedOnFoot(ped) then return false end
    if IsEntityDead(ped) then return false end
    if not IsPedHuman(ped) then return false end
    return true
   end

   RegisterCommand('carryped', function()
	TriggerEvent('np_carryped:EventoPed')
    end)



RegisterNetEvent('np_carryped:EventoPed')
AddEventHandler('np_carryped:EventoPed', function()
 hacerAnim('nm')
 hacerAnim('missfinale_c2mcs_1')
 local pedCercano = cogerNPC()
 if pedCercano then
  if IsEntityAttachedToEntity(pedCercano, GetPlayerPed(PlayerId())) then
   DetachEntity(pedCercano, GetPlayerPed(PlayerId()), true)
   ClearPedTasks(pedCercano)
   ClearPedTasks(GetPlayerPed(PlayerId()))
  else
   local pedCercano = cogerNPC()
   TaskPlayAnim(pedCercano, 'nm', 'firemans_carry', 8.0, -1, -1, 1, 1, 0, 0, 0)
   AttachEntityToEntity(pedCercano, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 40269), -0.1, 0.0, 0.1, 25.0, -290.0, -150.0, 1, 1, 0, 1, 0, 1)
   TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 1.0, -1, -1, 50, 0, 0, 0, 0)
    end
 end
end)

