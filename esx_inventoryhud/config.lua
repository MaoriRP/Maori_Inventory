Config = {}
Config.Locale = 'en'
Config.IncludeCash = true -- Include cash in inventory?
Config.IncludeWeapons = true -- Include weapons in inventory?
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)?
Config.ExcludeAccountsList = {"bank", "money"} -- List of accounts names to exclude from inventory
Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = false -- If true, police will be able to search players' trunks.
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.
Config.OpenKey = 246 -- Key for opening trunk

-- List of item names that will close ui when used
Config.CloseUiItems = {"headbag", "fishingrod", "tunerlaptop", "binoculars", "gps", "joint", "cigarette", "cigar", "fixkit", "rollingpaper", "cocaine", "meth"}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2

Config.Color = 2
Config.WeaponColor = 1

Config.WeaponLiscence = {x = 12.47, y = -1105.5, z = 29.8}
Config.LicensePrice = 5000

Config.Shops = {
    RegularShop = {
        Locations = {
		{x = 373.875, y = 325.896, z = 102.566},
		{x = 2557.458, y = 382.282, z = 107.622},
		{x = -3038.939, y = 585.954, z = 6.908},
		{x = -3241.927, y = 1001.462, z = 11.830},
		{x = 547.431,   y = 2671.710, z = 41.156},
		{x = 1961.464,  y = 3740.672, z = 31.343},
		{x = 2678.916,  y = 3280.671, z = 54.241},
		{x = 1729.216,  y = 6414.131, z = 34.037},
		{x = -48.519,   y = -1757.514, z = 28.421},
		{x = 1163.373,  y = -323.801,  z = 68.205},
		{x = -707.501,  y = -914.260,  z = 18.215},
		{x = -1820.523, y = 792.518,   z = 137.118},
		{x = 1698.388,  y = 4924.404,  z = 41.063},
		{x = 25.723,   y = -1346.966, z = 28.497}, 
        },
        Items = {
            {name = 'bread'},
            {name = 'water'}
     }},

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
            {name = 'beer'},
            {name = 'wine'},
            {name = 'vodka'},
            {name = 'tequila'},
            {name = 'whisky'},
            {name = 'grand_cru'}
    }},

    YouTool = {
        Locations = {
            {x = 2748.0, y = 3473.0, z = 55.68},
        },
        Items = {
            {name = 'drill'},
            {name = 'binocular'},
            {name = 'fixkit'},
            {name = 'gps'},
            {name = 'lockpick'},
            {name = 'scubagear'},
            {name = 'blowtorch'},
            {name = '1gbag'},
            {name = '5gbag'},
            {name = '50gbag'},
            {name = '100gbag'},
            {name = 'lowgradefert'},
            {name = 'highgradefert'},
            {name = 'plantpot'},
            {name = 'drugscales'}
    }},

    PrisonShop = {
        Locations = {
            {x = 1728.41, y = 2584.31, z = 45.84},
        },
        Items = {
            {name = 'bread'},
            {name = 'water'},
            {name = 'cigarette'},
            {name = 'lighter'},
            {name = 'sandwich'},
            {name = 'chips'}
    }},

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
        Weapons = {
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
        },
        Items = {
        }},
}

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10

Config.localWeight = {
	AED = 100,
	alive_chicken = 100,
	bandage = 100,
	beer = 100,
	blowpipe = 100,
	bong = 100,
	bread = 125,
	weed = 100,
	carokit = 100,
	carotool = 100,
	chocolate = 100,
	cigarett = 100,
	clip = 100,
	clothe = 100,
	cocacola = 100,
	cocaine = 100,
	coffe = 100,
	coke_pooch = 100,
	copper = 100,
	cupcake = 100,
	cutted_wood = 100,
	diamond = 100,
	essence = 100,
	fabric = 100,
	fish = 100,
	fishbait = 100,
	fishingrod = 100,
	fixkit = 100,
	fixtool = 100,
	gazbottle = 100,
	gold = 100,
	hamajifish = 100,
	hamburger = 100,
	icetea = 100,
	iron = 100,
	leather = 100,
	lighter = 100,
	marijuana = 350,
	marijuana_cigarette = 100,
	medikit = 100,
	meth = 100,
	meth_pooch = 100,
	milk = 100,
	oxygen_mask = 100,
	packaged_chicken = 100,
	packaged_plank = 100,
	petrol = 400,
	petrol_raffin = 100,
	prawn = 100,
	prawnbait = 100,
	sandwich = 100,
	shark = 100,
	slaughtered_chicken = 100,
	squid = 100,
	squidbait = 100,
	stone = 100,
	tequila = 100,
	turtle = 100,
	turtlebait = 100,
	vodka = 100,
	washed_stone = 100,
	water = 100,
	weaponflashlight = 100,
	weapongrip = 100,
	weaponskin = 100,
	weed_pooch = 100,
	whisky = 100,
	wine = 100,
	wood = 100,
	wool = 100,
	worm = 100,
	nothing = 300,
	porkpackage = 300,
	pork = 300,
	rice_pro = 300,
	rice = 300,
	phone = 300,
	chest_a = 25,
	chest_a = 25,
	nurek = 25,
	honey_b = 25,
	honey_a = 25,
	marijuana = 25,
	cannabis = 25,
	sickle = 25,
	pizza = 25,
	burger = 25,
	pastacarbonara = 25,
	macka = 25,
	cigarett = 25,
	pro_wood = 25,
	wood = 25,
	meth_pooch = 25,
	meth = 25,
	marijuana = 25,
	cannabis = 25,
	wool = 25,
	clothe = 25,
	glass = 25,
	sands = 25,
	bcabbage = 25,
	acabbage = 25,
	gold_t = 25,
	gold_o = 25,
	mushroom = 25,
	mushroom_d = 25,
	mushroom_p = 25,
	oil_b = 25,
	oil_a = 25,
	leather_a = 25,
	meat_a = 25,
	meat_w = 25,
	drill = 25,
	medikit = 25,
	medikit = 25,
	bandage = 25,
	gps = 25,
	fishingrod = 25,
	Cottageleaves_box = 25,
	marijuana = 25,
	cannabis = 25,
	WEAPON_SMG = 50,
	WEAPON_CARBINERIFLE = 3000,
	WEAPON_SPECIALCARBINE = 3000,
	WEAPON_ASSAULTRIFLE = 3000,
	WEAPON_PUMPSHOTGUN = 2000,
	WEAPON_PISTOL = 1000,
	WEAPON_APPISTOL = 1000,
	WEAPON_MACHINEPISTOL = 1500,
	WEAPON_COMBATPISTOL = 1000
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 70000, --SUV
    [3] = 25000, --Coupes
    [4] = 30000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 180000, --Off-road
    [10] = 300000, --Industrial
    [11] = 70000, --Utility
    [12] = 100000, --Vans
    [13] = 0, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 300000, --Commercial
    [21] = 0 --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
