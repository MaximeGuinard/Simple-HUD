util.AddNetworkString( "SendSpawnReceiveClient" ) 

local function spawn( ply )

	net.Start("SendSpawnReceiveClient")
	net.Send(ply) 

end

util.AddNetworkString("ModeChucho")
util.AddNetworkString("ModeParler")
util.AddNetworkString("ModeCrier")
util.AddNetworkString("ModeCrier2")
util.AddNetworkString("ModeParler2")
util.AddNetworkString("ModeChucho2")
util.AddNetworkString("OpenDermaVoice")
util.AddNetworkString("CloseDermaVoice")


net.Receive("ModeChucho", function(len, ply)
            ply:SetNWInt("RVSystemNW" , 0)
end) 

net.Receive("ModeChucho2", function(len, ply)
            ply:SetNWInt("RVSystemNW" , 0)	
end) 

net.Receive("ModeCrier", function(len, ply)
            ply:SetNWInt("RVSystemNW" , 2)
end) 

net.Receive("ModeCrier2", function(len, ply)
            ply:SetNWInt("RVSystemNW" , 2)
end) 

net.Receive("ModeParler", function(len, ply)
            ply:SetNWInt("RVSystemNW" , 1)
end) 

net.Receive("ModeParler2", function(len, ply)
            ply:SetNWInt("RVSystemNW" , 1)	
end)

hook.Add( "PlayerCanHearPlayersVoice", "RVSYSTEMHOOKS", function( listener, talker )
    if talker:GetNWInt("RVSystemNW") == 0 and listener:GetPos():Distance( talker:GetPos() ) > 100 then return false end
    if talker:GetNWInt("RVSystemNW") == 1 and listener:GetPos():Distance( talker:GetPos() ) > 300 then return false end
    if talker:GetNWInt("RVSystemNW") == 2 and listener:GetPos():Distance( talker:GetPos() ) > 800 then return false end
end )

hook.Add( "PlayerInitialSpawn", "RVSYSTEMHOOKSONPLAYERSPAWN", function(ply)
    ply:SetNWInt("RVSystemNW",1)
end)