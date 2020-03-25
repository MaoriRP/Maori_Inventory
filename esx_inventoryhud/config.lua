Config = {}
Config.Locale = "en"
Config.IncludeCash = true -- Include cash in inventory?
Config.IncludeWeapons = true -- Include weapons in inventory?
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)?
Config.ExcludeAccountsList = {"bank"} -- List of accounts names to exclude from inventory
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.

---------- Scrubz ----------
--Config.HotbarItems = {pistol, assaultrifle, advancedrifle}
----------------------------

-- List of item names that will close ui when used
Config.CloseUiItems = {"coke1g", "weedqtroz", "weedounce", "weedbrick", "coke1g", "meth", "crack"}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 52
Config.PrisonShopBlipID = 52
Config.WeaponShopBlipID = 110
Config.BahamaMama = 93
--Config.MegaMallBlipID = 52

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2
Config.MegaMallLength = 2

Config.Color = 2
Config.Color2 = 3
Config.WeaponColor = 1

Config.WeaponLiscence = {x = 12.47, y = -1105.5, z = 29.8}
Config.LicensePrice = 5000

Config.Shops = {
    RegularShop = {
        Locations = {
			{x = 373.875,   y = 325.896,  z = 103.566, icon = 52, color = 4, name = '7-Eleven'},
			{x = 2557.458,  y = 382.282,  z = 108.622, icon = 52, color = 4, name = '7-Eleven'},
			{x = -3038.939, y = 585.954,  z = 7.908, icon = 52, color = 4, name = '7-Eleven'},
			{x = -3241.927, y = 1001.462, z = 12.830, icon = 52, color = 4, name = '7-Eleven'},
			{x = 547.431,   y = 2671.710, z = 42.156, icon = 52, color = 4, name = '7-Eleven'},
			{x = 1961.464,  y = 3740.672, z = 32.343, icon = 52, color = 4, name = '7-Eleven'},
			{x = 2678.916,  y = 3280.671, z = 55.241, icon = 52, color = 4, name = '7-Eleven'},
			{x = 1729.216,  y = 6414.131, z = 35.037, icon = 52, color = 4, name = '7-Eleven'}
        },
        Items = {
            {name = 'sandwich'},
            {name = 'water'},
            {name = 'bandage'}
        }
    },

    RobsLiquor = {
		Locations = {
			{x = 1135.808,  y = -982.281,  z = 45.415},
			{x = -1222.915, y = -906.983,  z = 11.326},
			{x = -1487.553, y = -379.107,  z = 39.163},
			{x = -2968.243, y = 390.910,   z = 14.043},
			{x = 1166.024,  y = 2708.930,  z = 37.157},
			{x = 1392.562,  y = 3604.684,  z = 33.980},
			{x = -1393.409, y = -606.624,  z = 29.319}
        },
        Items = {
            {name = 'beer'}
        }
	},

    YouTool = {
        Locations = {
            {x = 2748.0, y = 3473.0, z = 55.68},
        },
        Items = {
            {name = 'plantpot'},
            {name = 'wrench'},
            {name = 'hammer'},
            {name = 'highgradefert'},
            {name = 'lowgradefert'}
        }
    },

    PrisonShop = {
        Locations = {
            {x = 1728.41, y = 2584.31, z = 45.84},
            --{x = 996.98, y = -3099.41, z = -38.50},
        },
        Items = {
            {name = 'sandwich'},
            {name = 'water'}
        }
    },

    WeaponShop = {
        Locations = {
            { x = -662.180, y = -934.961, z = 20.829 },
            { x = 810.25, y = -2157.60, z = 28.62 },
            { x = 1693.44, y = 3760.16, z = 33.71 },
            { x = -330.24, y = 6083.88, z = 30.45 },
            { x = 252.63, y = -50.00, z = 68.94 },
            { x = 22.09, y = -1107.28, z = 28.80 },
            { x = 2567.69, y = 294.38, z = 107.73 },
            { x = -1117.58, y = 2698.61, z = 17.55 },
            { x = 842.44, y = -1033.42, z = 27.19 },
        },
        --[[Weapons = {
            {name = "WEAPON_FLASHLIGHT", ammo = 1},
            {name = "WEAPON_STUNGUN", ammo = 1},
            {name = "WEAPON_KNIFE", ammo = 1},
            {name = "WEAPON_BAT", ammo = 1},
            {name = "WEAPON_PISTOL", ammo = 45},
            {name = "WEAPON_PUMPSHOTGUN", ammo = 25}
        },
        Ammo = {
            {name = "9mm_rounds", weaponhash = "WEAPON_PISTOL", ammo = 24},
            {name = "shotgun_shells", weaponhash = "WEAPON_PUMPSHOTGUN", ammo = 12}
        },]]
        Items = {
            {name = 'pistol'},
            {name = 'rifle_ammo'},
            {name = 'assaultrifle'},
            {name = 'advancedrifle'},
            {name = 'pistol_ammo'},
            {name = 'pistol_ammo_box'}
        }
    },

    LTDgasoline = {
		Locations = {
			{x = -48.519,   y = -1757.514, z = 29.421, icon = 52, color = 4, name = 'OKQ8'},
			{x = 1163.373,  y = -323.801,  z = 69.205, icon = 52, color = 4, name = 'OKQ8'},
			{x = -707.501,  y = -914.260,  z = 19.215, icon = 52, color = 4, name = 'OKQ8'},
			{x = -1820.523, y = 792.518,   z = 138.118, icon = 52, color = 4, name = 'OKQ8'},
			{x = 1698.388,  y = 4924.404,  z = 42.063, icon = 52, color = 4, name = 'OKQ8'}
        },
        Items = {
            {name = 'water'}
        }
    },

    MegaMall = {
        Locations = {
            {x = 46.66, y = -1749.78, z = 28.88},
        },
        Items = {
            {name = 'lockpick'},
            {name = 'advancedlockpick'},
            {name = 'bulletproof'},
            {name = 'phone'}
        }
    },

    BahamaMama = {
        Locations = {
            {x = -1393.409, y = -606.624,  z = 29.319}
        },
        Items = {
            {name = 'beer'}
        }
    },

    Vending = {
        Locations = {
            { x = 220.22,  y = -866.9,  z = 30.50 },
			{ x = 312.544, y = -587.664, z = 43.29 },
			{ x = 449.857, y = -987.882, z = 26.69 },
			{ x = -208.049, y = -1342.076, z = 34.9, },
			--Ecola
			{ x = 821.91,	y = -2988.64,  z = 6.02 },
			{ x = 820.81,	y = -2988.68,  z = 6.02 },
			{ x = 809.82,	y = -2150.0,   z = 29.62 },
			{ x = 2560.57,	y = 380.13,    z = 108.62 },
			{ x = 2558.81,	y = 2601.82,   z = 38.09 },
			{ x = 2344.35,	y = 3127.13,   z = 48.21 },
			{ x = 1702.89,	y = 4923.42,   z = 42.06 },
			{ x = 1485.8,	y = 1134.97,   z = 114.33 },
			{ x = 1160.96,	y = -319.77,   z = 69.21 },
			{ x = 286.14,	y = 195.21,    z = 104.37 },
			{ x = 309.33,	y = 186.95,    z = 103.9 },
			{ x = 285.59,	y = 80.36,     z = 94.36 },
			{ x = 281.68,	y = 66.38,     z = 94.37 },
			{ x = 436.23,	y = -986.68,   z = 30.69 },
			{ x = -59.84,	y = -1749.34,  z = 29.32 },
			{ x = -46.78,	y = -1753.18,  z = 29.42 },
			{ x = 19.83,	y = -1114.28,  z = 29.8 },
			{ x = -325.56,	y = -738.59,   z = 33.96 },
			{ x = -310.1,	y = -739.47,   z = 33.96 },
			{ x = -334.82,	y = -785.04,   z = 38.78 },
			{ x = -325.51,	y = -738.58,   z = 43.6 },
			{ x = -334.9,	y = -784.87,   z = 48.42 },
			{ x = -694.37,	y = -793.32,   z = 33.68 },
			{ x = -709.31,	y = -910.05,   z = 19.22 },
			{ x = -1654.96,	y = -1096.42,  z = 13.12 },
			{ x = -1695.27,	y = -1126.33,  z = 13.15 },
			{ x = -1710.02,	y = -1133.83,  z = 13.14 },
			{ x = -1692.37,	y = -1087.75,  z = 13.15 },
			{ x = -1063.66,	y = -244.41,   z = 39.73 },
			{ x = -1824.94,	y = 794.77,    z = 138.16 },
			{ x = -2550.63,	y = 2316.61,   z = 33.22 },
			{ x = -1269.34,	y = -1427.98,  z = 4.35 },
			{ x = -1251.39,	y = -1450.37,  z = 4.35 },
			{ x = -1230.58,	y = -1447.75,  z = 4.27 },
			{ x = -1170.79,	y = -1574.44,  z = 4.66 },
			{ x = -1148.0,	y = -1601.07,  z = 4.39 },
			{ x = -1140.06,	y = -1623.16,  z = 4.41 },
			{ x = -1123.07,	y = -1643.82,  z = 4.66 },
			{ x = -246.52,	y = -2002.96,  z = 30.15 },
			{ x = -275.87,	y = -2041.86,  z = 30.15 },
			--Sprunk
			{ x = 821.91,	y = -2988.64,  z = 6.02 },
			{ x = 820.81,	y = -2988.68,  z = 6.02 },
			{ x = 809.82,	y = -2150.0,   z = 29.62 },
			{ x = 2560.57,	y = 380.13,    z = 108.62 },
			{ x = 2558.81,	y = 2601.82,   z = 38.09 },
			{ x = 2344.35,	y = 3127.13,   z = 48.21 },
			{ x = 1702.89,	y = 4923.42,   z = 42.06 },
			{ x = 1485.8,	y = 1134.97,   z = 114.33 },
			{ x = 1160.96,	y = -319.77,   z = 69.21 },
			{ x = 286.14,	y = 195.21,    z = 104.37 },
			{ x = 309.33,	y = 186.95,    z = 103.9 },
			{ x = 285.59,	y = 80.36,     z = 94.36 },
			{ x = 281.68,	y = 66.38,     z = 94.37 },
			{ x = -59.84,	y = -1749.34,  z = 29.32 },
			{ x = -46.78,	y = -1753.18,  z = 29.42 },
			{ x = 19.83,	y = -1114.28,  z = 29.8 },
			{ x = -325.56,	y = -738.59,   z = 33.96 },
			{ x = -310.1,	y = -739.47,   z = 33.96 },
			{ x = -334.82,	y = -785.04,   z = 38.78 },
			{ x = -325.51,	y = -738.58,   z = 43.6 },
			{ x = -334.9,	y = -784.87,   z = 48.42 },
			{ x = -694.37,	y = -793.32,   z = 33.68 },
			{ x = -709.31,	y = -910.05,   z = 19.22 },
			{ x = -1654.96,	y = -1096.42,  z = 13.12 },
			{ x = -1695.27,	y = -1126.33,  z = 13.15 },
			{ x = -1710.02,	y = -1133.83,  z = 13.14 },
			{ x = -1692.37,	y = -1087.75,  z = 13.15 },
			{ x = -1063.66,	y = -244.41,   z = 39.73 },
			{ x = -1824.94,	y = 794.77,    z = 138.16 },
			{ x = -2550.63,	y = 2316.61,   z = 33.22 },
			{ x = -1269.34,	y = -1427.98,  z = 4.35 },
			{ x = -1251.39,	y = -1450.37,  z = 4.35 },
			{ x = -1230.58,	y = -1447.75,  z = 4.27 },
			{ x = -1170.79,	y = -1574.44,  z = 4.66 },
			{ x = -1148.0,	y = -1601.07,  z = 4.39 },
			{ x = -1140.06,	y = -1623.16,  z = 4.41 },
			{ x = -1123.07,	y = -1643.82,  z = 4.66 },
			{ x = -246.52,	y = -2002.96,  z = 30.15 },
			{ x = -275.87,	y = -2041.86,  z = 30.15 }
        },
        Items = {
            {name = 'water'}
        }
    },
}

-- Overall Weight Capacity //30kg
Config.Limit = 30000

--[[
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES 
('dbname', 'Name', 1, 0, 1, 0);
]]
-- Weight Options --
-- value == 0 //Item doesn't weigh anything.
-- value > 0 //Item has a weight value.
-- value < 0 //Item doesn't weigh anything, but can't be stacked
Config.DefaultWeight = 1000

Config.localWeight = {
    advancedlockpick = 250,
    advancedrifle = 6000,  -- Assault Rifle  //Special//
    assaultrifle = 7000,  -- AK-47  //Criminal//
    baggie = 0,
    bandage = 100,
    bat = 1000,
    battery = 100,
    batteryacid = 100,
    battleaxe = 1000,
    beefjerky = 100,
    beer = 100,
    bakingsoda = 100,
    bottle = 200,
    bulletproof = 1000,  -- Bulletproof Vest
    bullpuprifle = 7000,  -- Bullpup Rifle  //Special// - Fires faster than the assault rifle
    burger = 100,
    carbinerifle = 6500,  -- Police M4
    cheapbaggie = 0,
    coke1g = 100,
    cocainebrick = 10000,
    combatpdw = 7000,  -- MPX  //Special//
    compactrifle = 6000,  -- Draco (ak)  //Special//
    cookingpot = 500,
    crack1g = 100,
    crowbar = 1000,
    dbshotgun = 5200,  -- Double Barrel  //Special//
    doubleaction = 3000,  -- Gold Revolver  //Specail//
    drugscales = 1000,  -- Large Scale
    drugspackage = 10000,
    fireextinguisher = 1500,
    fireextinguisher_ammo = 0,
    firework = 0,
    flare = 0,
    flaregun = 0,
    faregun_ammo = 0,
    flashlight = 250,
    garbagebag = 100,
    golfclub = 600,
    gusenberg = 5200,  -- Thompson SMG  //Criminal//
    hammer = 500,
    handcuffs = 100,
    hatchet = 1000,
    heavypistol = 3000,  -- Glock  //Criminal//
    highgradefemaleseed = 0,
    highgradefert = 100,
    highgrademaleseed = 0,
    knife = 100,
    knuckle = 0,  -- Knuckledusters
    lithium = 100,
    lockpick = 100,
    lowgradefemaleseed = 0,
    lowgradefert = 100,
    lowgrademaleseed = 0,
    machete = 1000,
    machinepistol = 4500,  -- Tec-9 SMG  //Criminal//
    marksmanpistol = 4000,  -- 1776  //Special//
    medikit = 100,
    meth1g = 100,
    microsmg = 4000,  -- Micro SMG  //Special//
    minismg = 4000,  -- Skorpio  //Might Use As BlueMoon Special//
    musket = 6000,  -- Boomstick  //Special//
    nightstick = 100,
    ogkush = 100,
    parachute = 1000,
    petrolcan = 2500,
    phone = 100,
    -- Add more phone variants
    pistol = 3000,  -- Civilian
    pistol_ammo = 100,
    --pistol_ammo_box = 200,
    pistol_mk2 = 3000,  -- Advanced Pistol  //Might Use As BlueMoon Special//
    plantpot = 1000,
    poolcue = 800,
    psuedoephedrine = 200,
    pumpshotgun = 5200,  -- Remington 870
    purifiedwater = 400,
    pyrex = 200,
    --radio = 100,
    rawcoke = 100,
    rawmeth = 100,
    rawcrack = 100,
    --reggie = ,
    repairkit = 2000,
    revolver = 3000,  -- Heavy Revolver  //Prob Won't Use//
    rifle_ammo = 100,
    --rifle_ammo_box = 200,
    rollingpapers = 0,
    sandwich = 100,
    sawnoffshotgun = 4800, -- Mossberg 500  //Prob Won't Use//
    shotgun_ammo = 100,
    --shotgun_ammo_box = 200,
    smallscale = 500,  -- Small Scale
    smg = 4500,  -- MP5  //Special//
    smg_ammo = 100,
    --smg_ammo_box = 200,
    snowball = 0,
    snspistol = 2800,  -- Civilian
    snspistol_mk2 = 2200,  -- Pocket Rocket  //Special//
    specialcarbine = 7500,  -- G36  //Prob Won't Use//
    stungun = 2500,
    stungun_ammo = 0,
    switchblade = 100,
    --trimmedweed = ,
    vintagepistol = 3000,  -- Civilian
    water = 100,
    wateringcan = 1000,
    weebrick = 10000,
    weedounce = 1000,
    weedqtroz = 100,
    wool = 0,
    wrench = 500,
    ziplock = 100,
}