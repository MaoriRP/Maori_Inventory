local roboestado = false

RegisterCommand('roubar', function(source, args)
	TriggerEvent('OpenBodySearchMenu')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
 local ped = PlayerPedId()

		if IsControlJustPressed(1, 38) and IsControlPressed(1, 36) and IsPedArmed(ped, 7) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then
			if CheckIsPedDead() then  
				exports['mythic_notify']:DoCustomHudText('error', 'A Vítima está morta',4000)
		else
		  robo()
		end
 end
	end
end)

function robo()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 1.5 then
		local target, distance = ESX.Game.GetClosestPlayer()
		playerheading = GetEntityHeading(GetPlayerPed(-1))
		playerlocation = GetEntityForwardVector(PlayerPedId())
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local target_id = GetPlayerServerId(target)
		local searchPlayerPed = GetPlayerPed(target)

		if distance <= 1.5 then
			if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 then
				TriggerServerEvent('robo:jugador', target_id, playerheading, playerCoords, playerlocation)
				Citizen.Wait(4500)
			else
				exports['mythic_notify']:DoCustomHudText('error', 'Não Tem as Mãos Levantadas.')	
			end
		end
	else
		 exports['mythic_notify']:DoCustomHudText('error', 'Sem Jogadores Perto')
    end
end

function CheckIsPedDead()
local target, distance = ESX.Game.GetClosestPlayer()
   local searchPlayerPed = GetPlayerPed(target)
	if IsPedDeadOrDying(searchPlayerPed)  then
		return true
	end
	return false
end

RegisterNetEvent('robo:getarrested')
AddEventHandler('robo:getarrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	roboestado = true
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) 
	local x, y, z   = table.unpack(playercoords + playerlocation * 0.85)
	SetEntityCoords(GetPlayerPed(-1), x, y, z-0.50)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('random@mugging3')
	TaskPlayAnim(GetPlayerPed(-1), 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0.0, false, false, false)
	roboestado = true
	Citizen.Wait(12500)
	roboestado = false
end)

RegisterNetEvent('robo:doarrested')
AddEventHandler('robo:doarrested', function()
	local target, distance = ESX.Game.GetClosestPlayer()
	Citizen.Wait(250)
	loadanimdict('combat@aim_variations@arrest')
	TaskPlayAnim(GetPlayerPed(-1), 'combat@aim_variations@arrest', 'cop_med_arrest_01', 8.0, -8,3750, 2, 0, 0, 0, 0)
	exports['progressBars']:startUI(3500, " Buscando Objetos ")	
	Citizen.Wait(3000)
	OpenBodySearchMenu(target)
end) 

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

function OpenBodySearchMenu(player)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName,8.0, -8.0, -1, 49, 0, false, false, false)
	RemoveAnimDict(animDict)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if roboestado then
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
		    DisableControlAction(0, 263, true) -- Melee Attack 1
	        DisableControlAction(0, 217, true) -- Also 'enter'?
		    DisableControlAction(0, 137, true) -- Also 'enter'?		
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

		if IsEntityPlayingAnim(playerPed, 'random@mugging3', 'handsup_standing_base', 3) ~= 1 then
				 ESX.Streaming.RequestAnimDict('random@mugging3', function()
				 TaskPlayAnim(playerPed, 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0.0, false, false, false)
						
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)
-- [[  script created and modified by ShinxD and karen, for latamrp and fivem forum.  ]] --
