
local Main = CM.Modules["Main"]

function Main.ConnectToDB()
	Main.DB = newDB()
	Main.DB:Init("91.121.182.29","spy","DNuHbwVPvfqGW9fS","spy")
	return Main.DB:IsConnecting() 
end

function Main.Query(str, callback)
	if callback == nil then callback = CALLBACK_PRINTTABLE end --debug stuff
	Main.q = newQuery()
	Main.q:SetDB(Main.DB)
	Main.q:SetString(str)
	Main.q:SetCallback(callback) 
	Main.q:Run()
end

local vars ={ "money" } -- Vars of stored value in player userdata e.g. ply.money, ply.faction

function Main.GetPlayerDetails(ply)
	local function callback(data)
		local res = data[1]
		ply.money = res.money
	end

	Main.Query("SELECT * FROM cm_users WHERE ".. ply:SteamID64() .." = sid", callback)
end

function Main.PlayerExists(ply)
	local function callback(data, self)
		if #data > 0 then
			return true
		else
			Main.Query("INSERT INTO cm_users VALUES (".. ply:SteamID64() .. ",".. ply.money .. ")", nil)
		end
	end
	Main.Query("SELECT sid FROM cm_users WHERE ".. ply:SteamID64() .." = sid", callback)
end

function Main.SavePlayerDetails(ply)
	local function callback(data)
		MsgC(Color(255,255,255), "INFO: ", Color(0,255,0), ply:Nick() .. ", Saved details to database! \n")
	end	
	Main.Query("UPDATE cm_users SET money="..ply.money.." WHERE ".. ply:SteamID64() .." = sid", callback)
end

function Main.BackupData(tbl) -- Takes a table of players or does everyone
	hook.Call("BackingUp")
	if tbl == nil then tbl = player.GetAll() end
	for k,v in pairs(tbl) do
		Main.SavePlayerDetails(v)
	end
	hook.Call("BackedUp")
end

hook.Add("BackingUp", "NotifyingPlayersOfPossibleLag", function()
	PrintMessage(HUD_PRINTTALK, "Backing up your data! Prepare for possible lag!")
end)

hook.Add("BackedUp", "LagsGone", function()
	PrintMessage(HUD_PRINTTALK, "Backed up your data! Problem solved!")
end)


timer.Create("CMBackupPlayerData", 600, 0, Main.BackupData)

CM.Modules["Main"] = Main