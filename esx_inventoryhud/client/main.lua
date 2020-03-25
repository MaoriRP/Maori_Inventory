local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local trunkData = nil
local isInInventory = false
ESX = nil
local fastWeapons = {
	[1] = nil,
	[2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil
}

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                TriggerScreenblurFadeIn(0)
                Citizen.Wait(50)
                openInventory()
            end
        end
    end
)

function openInventory()
    loadPlayerInventory()
    isInInventory = true
    
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end

function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(0)
    ClearPedSecondaryTask(GetPlayerPed(-1))
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
        Citizen.Wait(50)
        TriggerScreenblurFadeOut(0)
    end
)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true

                table.insert(
                    elements,
                    {
                        label = GetPlayerName(players[i]),
                        player = GetPlayerServerId(players[i])
                    }
                )
            end
        end

        if not foundPlayers then
            --[[exports.pNotify:SendNotification(
                {
                    text = _U("players_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )--]] --Uncomment This to Use pNotify
            exports['mythic_notify']:SendAlert('error', _U("players_nearby"))
        else
            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
            )
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "PutIntoTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromTrunk",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx_trunk:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        TriggerServerEvent("esx:useItem", data.item.name)
        Citizen.Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback("DropItem",function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
    end
    Wait(250)
    loadPlayerInventory()
    local dict = "pickup_object"		
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(GetPlayerPed(-1), dict, "pickup_low", 8.0, 8.0, -1, 0, 1, false, false, false)
    cb("ok")
end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

        if foundPlayer then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx:giveInventoryItem", data.player, data.item.type, data.item.name, count)
            Wait(500)
            loadPlayerInventory()
        else
            exports['mythic_notify']:SendAlert('error', _U("player_nearby"))
            --[[exports.pNotify:SendNotification(
                {
                    text = _U("player_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )--]] -- Uncomment This to Use pNotify
        end
        cb("ok")
    end
)

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

--local arrayWeight = Config.localWeight
function getInventoryWeight(inventory)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
      if inventory[i] ~= nil then
        itemWeight = Config.DefaultWeight
        if arrayWeight[inventory[i].name] ~= nil then
          itemWeight = arrayWeight[inventory[i].name]
        end
        weight = weight + (itemWeight * (inventory[i].count or 1))
      end
    end
  end
  return weight
end

local itemList = {sandwich}

function allowedItem(itemName)
    for k, v in ipairs(itemList) do
        if v == itemName then
            return true
        end
    end
    return false
end

function loadPlayerInventory()
    ESX.TriggerServerCallback(
        "esx_inventoryhud:getPlayerInventory",
        function(data)
            items = {}
            fastWeapons = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money

            if Config.IncludeCash and money ~= nil and money > 0 then
                for key, value in pairs(accounts) do
                    moneyData = {
                        label = _U("cash"),
                        name = "cash",
                        type = "item_money",
                        count = money,
                        usable = false,
                        rare = false,
                        limit = -1,
                        canRemove = true
                    }

                    table.insert(items, moneyData)
                end
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                limit = -1,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end

            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        table.insert(items, inventory[key])
                        --widgetTotal = getInventoryWeight(items)
                    end
                end
            end

            --[[if fastWeapons ~= nil then
                for k, v in pairs(items) do
                    for k, v in pairs(fastWeapons) do
                        if fastWeapons[k].count <= 0 then
                            fastWeapons[k] = nil
                        elseif fastWeapons[k].name == items[k].name then
                            table.insert(fastItems, {
                                label = items[k].label,
                                count = items[k].count,
                                limit = -1,
                                type = items[k].type,
                                name = items[k].name,
                                usable = false,
                                rare = false,
                                canRemove = true,
                                slot = k
                            })
                            break
                        end
                    end
                end
                print("Slots Loaded")
            end]]
            print("Inventory Loaded")

        --[[else
            inventory[key].type = "item_standard"
            inventory[key].usable = false
            inventory[key].rare = false
            inventory[key].limit = -1
            inventory[key].canRemove = false
            table.insert(items, inventory[key])
        end]]

            --[[if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
                        local found = false
                        for slot, weapon in pairs(fastWeapons) do
                            if weapon == weapons[key].name then
                                local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                                table.insert(
                                    fastItems,
                                    {
                                        label = weapons[key].label,
                                        count = ammo,
                                        limit = -1,
                                        type = "item_weapon",
                                        name = weapons[key].name,
                                        usable = false,
                                        rare = false,
                                        canRemove = true,
                                        slot = slot
                                    }
                                )
                                found = true
                                break
                            end
                        end
                        if found == false then
                            local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                            table.insert(
                                items,
                                {
                                    label = weapons[key].label,
                                    count = ammo,
                                    limit = -1,
                                    type = "item_weapon",
                                    name = weapons[key].name,
                                    usable = false,
                                    rare = false,
                                    canRemove = true
                                }
                            )
                        end
                    end
                end
            end]]
			
			local arrayWeight = Config.localWeight
			local weight = 0
			local itemWeight = 0
			local itemsW = 0
			if items ~= nil then
			for i = 1, #items, 1 do
				if items[i] ~= nil then
				  itemWeight = Config.DefaultWeight
				  itemWeight = itemWeight / items[1].count * 0.0
				if arrayWeight[items[i].name] ~= nil then
				  itemWeight = arrayWeight[items[i].name]
				  items[i].limit = itemWeight / 1000
				end
				  weight = weight + (itemWeight * (items[i].count or 1))
				end
		      end
			end
			
			local texts =  _U("player_info", GetPlayerName(PlayerId()), (weight / 1000), (Config.Limit / 1000))
			
            if weight > Config.Limit then
                exports['mythic_notify']:SendAlert('error', 'Inventory full! Unable to walk.')
			   setHurt()
			   
			   texts = _U("player_info_full", GetPlayerName(PlayerId()), (weight / 1000), (Config.Limit / 1000))
			elseif weight <= Config.Limit then
			   setNotHurt()
			   texts =  _U("player_info", GetPlayerName(PlayerId()), (weight / 1000), (Config.Limit / 1000))
			end
			
            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items,
                    fastItems = fastItems,
					text = texts
                }
            )
			
        end,
        GetPlayerServerId(PlayerId())
    )
end

function setHurt()
    FreezeEntityPosition(GetPlayerPed(-1), true)
end
			 
function setNotHurt()
	 FreezeEntityPosition(GetPlayerPed(-1), false)
end

RegisterCommand('printtable', function(source, args, raw)
    for k, v in pairs(fastWeapons) do
        local debug = string.format('Slot: %s - Item: %s', k, v.label)
        print(debug)
    end
end, false)

RegisterNetEvent("esx_inventoryhud:openTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:openTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
        openTrunkInventory()
    end
)

RegisterNetEvent("esx_inventoryhud:refreshTrunkInventory")
AddEventHandler(
    "esx_inventoryhud:refreshTrunkInventory",
    function(data, blackMoney, inventory, weapons)
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
    end
)

function setTrunkInventoryData(data, blackMoney, inventory, weapons)
    trunkData = data
	
		SendNUIMessage(
			{
				action = "setInfoText",
				text = data.text
			}
		)			

    items = {}

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].rare = false
                inventory[key].limit = -1
                inventory[key].canRemove = false
                table.insert(items, inventory[key])
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end
	
    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openTrunkInventory()
    TriggerScreenblurFadeIn(0)
    loadPlayerInventory()
    isInInventory = true
    local playerPed = GetPlayerPed(-1)
    if not IsEntityPlayingAnim(playerPed, 'mini@repair', 'fixing_a_player', 3) then
        ESX.Streaming.RequestAnimDict('mini@repair', function()
            TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end)
    end

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 1, true) -- Disable pan
                DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, Keys["W"], true) -- W
                DisableControlAction(0, Keys["A"], true) -- A
                DisableControlAction(0, 31, true) -- S (fault in Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Keys table!)

                DisableControlAction(0, Keys["R"], true) -- Reload
                DisableControlAction(0, Keys["SPACE"], true) -- Jump
                DisableControlAction(0, Keys["Q"], true) -- Cover
                DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
                DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

                DisableControlAction(0, Keys["F1"], true) -- Disable phone
                DisableControlAction(0, Keys["F2"], true) -- Inventory
                DisableControlAction(0, Keys["F3"], true) -- Animations
                DisableControlAction(0, Keys["F6"], true) -- Job

                DisableControlAction(0, Keys["V"], true) -- Disable changing view
                DisableControlAction(0, Keys["C"], true) -- Disable looking behind
                DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
                DisableControlAction(2, Keys["P"], true) -- Disable pause screen

                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end
)

-- HIDE WEAPON WHEEL
--[[Citizen.CreateThread(function ()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(0)
		HideHudComponentThisFrame(19)
		HideHudComponentThisFrame(20)
        BlockWeaponWheelThisFrame()
        HudWeaponWheelIgnoreSelection()
		--DisableControlAction(0,Keys["TAB"],true)
	end
end)]]

--FAST ITEMS
--[[RegisterNUICallback(
    "PutIntoFast",
    function(data, cb)
		if data.item.slot ~= nil then
			fastWeapons[data.item.slot] = nil
		end
		fastWeapons[data.slot] = data.item.name
		--TriggerServerEvent("esx_inventoryhud:changeFastItem",data.slot,data.item.name)
		loadPlayerInventory()
		cb("ok")
	end
)
RegisterNUICallback(
    "TakeFromFast",
    function(data, cb)
		fastWeapons[data.item.slot] = nil
		--TriggerServerEvent("esx_inventoryhud:changeFastItem",0,data.item.name)
		loadPlayerInventory()
		cb("ok")
	end
)]]

RegisterNUICallback(
    "PutIntoFast",
    function(data, cb)
		if data.item.slot ~= nil then
			fastWeapons[data.item.slot] = nil
		end
		fastWeapons[data.slot] = data.item.name
        --TriggerServerEvent("esx_inventoryhud:changeFastItem",data.slot,data.item.name)
        print("Put into slot")
        loadPlayerInventory()
        cb("ok")

	end
)

RegisterNUICallback(
    "TakeFromFast",
    function(data, cb)
		fastWeapons[data.item.slot] = nil
        --TriggerServerEvent("esx_inventoryhud:changeFastItem",0,data.item.name)
        print("Removed from slot")
		loadPlayerInventory()
		cb("ok")
	end
)

--[[Citizen.CreateThread(
    function()
		while true do
            Citizen.Wait(0)
            if IsDisabledControlJustReleased(1, Keys["1"]) then
                if fastWeapons[1] ~= nil then
					if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[1]) then
						SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
					else
						SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[1],true)
					end
				end
            end
			if IsDisabledControlJustReleased(1, Keys["2"]) then
                if fastWeapons[2] ~= nil then
					if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[2]) then
						SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
					else
						SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[2],true)
					end
				end
            end
			if IsDisabledControlJustReleased(1, Keys["3"]) then
                if fastWeapons[3] ~= nil then
					if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[3]) then
						SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
					else
						SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[3],true)
					end
				end
            end
            if IsDisabledControlJustReleased(1, Keys["4"]) then
                if fastWeapons[4] ~= nil then
					if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[4]) then
						SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
					else
						SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[4],true)
					end
				end
            end
            if IsDisabledControlJustReleased(1, Keys["5"]) then
                if fastWeapons[5] ~= nil then
					if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey(fastWeapons[5]) then
						SetCurrentPedWeapon(GetPlayerPed(-1), "WEAPON_UNARMED",true)
					else
						SetCurrentPedWeapon(GetPlayerPed(-1), fastWeapons[5],true)
					end
				end
            end
        end
    end
)]]


--Add Items--

RegisterNetEvent('esx_inventoryhud:client:addItem')
AddEventHandler('esx_inventoryhud:client:addItem', function(itemname, itemlabel)
    local data = { name = itemname, label = itemlabel }
    SendNUIMessage({type = "addInventoryItem", addItemData = data})
end)

---------------------------
-- Scrubz Weapon Stuffs --
---------------------------
local weaponInfo = 
{
    [1] = {id = 'advancedrifle', hash = "WEAPON_ADVANCEDRIFLE"},
    [2] = {id = 'appistol', hash = "WEAPON_APPISTOL"},
    [3] = {id = 'assaultrifle', hash = "WEAPON_ASSAULTRIFLE"},
    [4] = {id = 'wrench', hash = "WEAPON_WRENCH"},
    [5] = {id = 'assaulshotgun', hash = "WEAPON_ASSAULTSHOTGUN"},
    [6] = {id = 'assualtsmg', hash = "WEAPON_ASSAULTSMG"},
    [7] = {id = 'ball', hash = "WEAPON_BALL"},
    [8] = {id = 'bat', hash = "WEAPON_BAT"},
    [9] = {id = 'battleaxe', hash = "WEAPON_BATTLEAXE"},
    [10] = {id = 'bottle', hash = "WEAPON_BOTTLE"},
    [11] = {id = 'bullpuprifle', hash = "WEAPON_BULLPUPRIFLE"},
    [12] = {id = 'bzgas', hash = "WEAPON_BZGAS"},
    [13] = {id = 'carbinerifle', hash = "WEAPON_CARBINERIFLE"},
    [14] = {id = 'combatmg', hash = "WEAPON_COMBATMG"},
    [15] = {id = 'combatpdw', hash = "WEAPON_COMBATPDW"},
    [16] = {id = 'combatpistol', hash = "WEAPON_COMBATPISTOL"},
    [17] = {id = 'compactrifle', hash = "WEAPON_COMPACTRIFLE"},
    [18] = {id = 'crowbar', hash = "WEAPON_CROWBAR"},
    [19] = {id = 'dagger', hash = "WEAPON_DAGGER"},
    [20] = {id = 'dbshotgun', hash = "WEAPON_DBSHOTGUN"},
    [21] = {id = 'digiscanner', hash = "WEAPON_DIGISCANNER"},
    [22] = {id = 'doubleaction', hash = "WEAPON_DOUBLEACTION"},
    [23] = {id = 'fireextinguisher', hash = "WEAPON_FIREEXTINGUISHER"},
    [24] = {id = 'flare', hash = "WEAPON_FLARE"},
    [25] = {id = 'flaregun', hash = "WEAPON_FLAREGUN"},
    [26] = {id = 'flashlight', hash = "WEAPON_FLASHLIGHT"},
    [27] = {id = 'golfclub', hash = "WEAPON_GOLFCLUB"},
    [28] = {id = 'grenade', hash = "WEAPON_GRENADE"},
    [29] = {id = 'gusenberg', hash = "WEAPON_GUSENBERG"},
    [30] = {id = 'hammer', hash = "WEAPON_HAMMER"},
    [31] = {id = 'handcuffs', hash = "WEAPON_HANDCUFFS"},
    [32] = {id = 'hatchet', hash = "WEAPON_HATCHET"},
    [33] = {id = 'heavypistol', hash = "WEAPON_HEAVYPISTOL"},
    [34] = {id = 'heavyshotgun', hash = "WEAPON_HEAVYSHOTGUN"},
    [35] = {id = 'knife', hash = "WEAPON_HEAVYSNIPER"},
    [36] = {id = 'knuckle', hash = "WEAPON_KNIFE"},
    [37] = {id = 'knuckle', hash = "WEAPON_KNUCKLE"},
    [38] = {id = 'machete', hash = "WEAPON_MACHETE"},
    [39] = {id = 'machinepistol', hash = "WEAPON_MACHINEPISTOL"},
    [40] = {id = 'marksmanpistol', hash = "WEAPON_MARKSMANPISTOL"},
    [41] = {id = 'marksmanrifle', hash = "WEAPON_MARKSMANRIFLE"},
    [42] = {id = 'microsmg', hash = "WEAPON_MICROSMG"},
    [43] = {id = 'minismg', hash = "WEAPON_MINISMG"},
    [44] = {id = 'molotov', hash = "WEAPON_MOLOTOV"},
    [45] = {id = 'musket', hash = "WEAPON_MUSKET"},
    [46] = {id = 'nightstick', hash = "WEAPON_NIGHTSTICK"},
    [47] = {id = 'parachute', hash = "GADGET_PARACHUTE"},
    [48] = {id = 'petrolcan', hash = "WEAPON_PETROLCAN"},
    [49] = {id = 'pistol', hash = "WEAPON_PISTOL"},
    [50] = {id = 'pistol50', hash = "WEAPON_PISTOL50"},
    [51] = {id = 'pistol_mk2', hash = "WEAPON_PISTOL_MK2"},
    [52] = {id = 'poolcue', hash = "WEAPON_POOLCUE"},
    [53] = {id = 'pumpshotgun', hash = "WEAPON_PUMPSHOTGUN"},
    [54] = {id = 'revolver', hash = "WEAPON_REVOLVER"},
    [55] = {id = 'rpg', hash = "WEAPON_RPG"},
    [56] = {id = 'sawnoffshotgun', hash = "WEAPON_SAWNOFFSHOTGUN"},
    [57] = {id = 'smg', hash = "WEAPON_SMG"},
    [58] = {id = 'smokegrenade', hash = "WEAPON_SMOKEGRENADE"},
    [59] = {id = 'sniperrifle', hash = "WEAPON_SNIPERRIFLE"},
    [60] = {id = 'snowball', hash = "WEAPON_SNOWBALL"},
    [61] = {id = 'snspistol', hash = "WEAPON_SNSPISTOL"},
    [62] = {id = 'snspistol_mk2', hash = "WEAPON_SNSPISTOL_MK2"},
    [63] = {id = 'stungun', hash = "WEAPON_STUNGUN"},
    [64] = {id = 'switchblade', hash = "WEAPON_SWITCHBLADE"},
    [65] = {id = 'vintagepistol', hash = "WEAPON_VINTAGEPISTOL"}
}

-- Checking if weapon is equipped and removing from the wheel if it is.
RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(name, count)
    local plyPed = GetPlayerPed(-1)
    for k, v in pairs(weaponInfo) do
        if v.id == name then
            if HasPedGotWeapon(plyPed, v.hash, false) then
                SetPedAmmo(plyPed, GetHashKey(v.hash), 0)
                Citizen.Wait(5)
                RemoveWeaponFromPed(plyPed, GetHashKey(v.hash))
                print("Weapon removed from wheel")
            else
                print("Weapon not equipped")
            end
        end
    end
end)

-- Printing the weapons group hash.
RegisterCommand('printweapon', function(source, args, raw)
    local plyPed = GetPlayerPed(-1)
    local currentWeapon = GetSelectedPedWeapon(plyPed)
    local weaponType = GetWeapontypeGroup(GetHashKey(currentWeapon))
    print(weaponType)
end, false)

-- Adding ammo. Will need to trigger this when using an item to give ammo. //Ammo Box//
RegisterNetEvent('scrubz_weaponsystem_cl:addAmmo')
AddEventHandler('scrubz_weaponsystem_cl:addAmmo', function(item, amount)
    local plyPed = GetPlayerPed(-1)
    local currentWeapon = GetSelectedPedWeapon(plyPed)
    local weaponType = GetWeapontypeGroup(GetHashKey(currentWeapon))
    if item == "ammopistol" then
        if weaponType == 416676503 then  -- Pistol
            SetPedAmmo(plyPed, currentWeapon, amount)
            exports['mythic_notify']:SendAlert('success', "Added rounds to your pistol.")
        elseif weaponType == -957766203 or weaponType == 1159398588 or weaponType == 860033945 or weaponType == 970310034 then
            exports['mythic_notify']:SendAlert('error', "A pistol is not equipped.")
        elseif weaponType == -1609580060 then  -- Unarmed
            exports['mythic_notify']:SendAlert('error', "You just gonna throw the ammo at people??")
        end
    elseif item == "ammosmg" then
        if weaponType == -957766203 or weaponType == 1159398588 then  -- SMG
            SetPedAmmo(plyPed, currentWeapon, amount)
            exports['mythic_notify']:SendAlert('success', "Added 30 rounds to your SMG.")
        elseif weaponType == -1609580060 then  -- Unarmed
            exports['mythic_notify']:SendAlert('error', "You just gonna throw the ammo at people??")
        elseif weaponType == 416676503 or weaponType == 860033945 or weaponType == 970310034 then
            exports['mythic_notify']:SendAlert('error', "A smg is not equipped.")
        end
    elseif item == "ammoshotgun" then
        if weaponType == 860033945 then  -- Shotgun
            SetPedAmmo(plyPed, currentWeapon, amount)
            exports['mythic_notify']:SendAlert('success', "Added 30 rounds to your shotgun.")
        elseif weaponType == -1609580060 then  -- Unarmed
            exports['mythic_notify']:SendAlert('error', "You just gonna throw the ammo at people??")
        elseif weaponType == 416676503 or weaponType == -957766203 or weaponType == 1159398588 or weaponType == 970310034 then
            exports['mythic_notify']:SendAlert('error', "A shotgun is not equipped.")
        end
    elseif item == "ammorifle" then  -- Rifle
        if weaponType == 970310034 then
            SetPedAmmo(plyPed, currentWeapon, amount)
            exports['mythic_notify']:SendAlert('success', "Added 30 rounds to your rifle.")
        elseif weaponType == -1609580060 then  -- Unarmed
            exports['mythic_notify']:SendAlert('error', "You just gonna throw the ammo at people??")
        elseif weaponType == 416676503 or weaponType == -957766203 or weaponType == 1159398588 or weaponType == 860033945 then
            exports['mythic_notify']:SendAlert('error', "A rifle is not equipped.")
        end
    end
end)

-- Adding a weapon to the wheel
RegisterNetEvent('scrubz_weaponsystem_cl:addWeapon')
AddEventHandler('scrubz_weaponsystem_cl:addWeapon', function(weapon)
    local plyPed = GetPlayerPed(-1)
    for k, v in pairs(weaponInfo) do
        if weapon == v.id then
            if not HasPedGotWeapon(plyPed, GetHashKey(v.hash), false) then
                GiveWeaponToPed(plyPed, GetHashKey(v.hash), 0, false, false)
            else
                exports['mythic_notify']:SendAlert('error', 'You already have that weapon equipped!')
            end
        end
    end
end)

