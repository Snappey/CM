
local Main = CM.Modules["Main"]

function Main.ConnectToDB()
	Main.DB = newDB()
	Main.DB:Init("91.121.182.29","spy","DNuHbwVPvfqGW9fS","spy")
end

CM.Modules["Main"] = Main