--Server stuff for the GUI for ULX --  by Stickly Man!

Msg( "///////////////////////////////\n" )
Msg( "// ULX GUI -- by Stickly Man //\n" )
Msg( "///////////////////////////////\n" )
Msg( "//   Adding GUI Modules..    //\n" )

local xgui_module_files = file.FindInLua( "ulx/modules/cl/gui_modules/*.lua" )

for _, file in ipairs( xgui_module_files ) do
	AddCSLuaFile( "ulx/modules/cl/gui_modules/" .. file )
	Msg( "//  MODULE: " .. file .. string.rep( " ", 17 - file:len() ) .. "//\n" )
end

Msg( "//   GUI Modules Added!      //\n" )
Msg( "///////////////////////////////\n" )

AddCSLuaFile( "ulx/modules/cl/xgui_helpers.lua" )

local function getAdmins( ply )
	local status
	for k, v in pairs( ULib.ucl.users ) do
		umsg.Start( "xgui_admin", ply )
		for a, b in pairs( player.GetAll() ) do
			if b:SteamID() == v.id then
				status = "Online"
				umsg.String( b:Nick() )
				break
			else
				status = "Unavailable"
				umsg.String( k )
			end
		end
		umsg.String( table.concat( v.groups ) )
		umsg.String( status )
		umsg.String( v.id )
		umsg.End()
	end
end
ULib.concommand( "xgui_requestadmins", getAdmins )

local function getGamemodes( ply )
	local dirs = file.FindDir( "../gamemodes/*" )
		for _, dir in ipairs( dirs ) do
			if file.Exists( "../gamemodes/" .. dir .. "/info.txt" ) and not util.tobool( util.KeyValuesToTable( file.Read( "../gamemodes/" .. dir .. "/info.txt" ) ).hide ) then
				umsg.Start( "xgui_gamemode_rcv", ply )
					umsg.String( dir )
				umsg.End()
			end
		end
end
ULib.concommand( "xgui_requestgamemodes", getGamemodes )