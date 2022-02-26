SimpleHudColor = {}


-- NE PAS TOUCHER
local Wss = ScrW()/1920
local Hss = ScrH()/1080

-- FONTS
surface.CreateFont("lss_1",
{
    font = "Lato Light", 
    size = Hss* 19,
    weight = 500,
    antialias = true,
    strikeout = true,
    additive = true,
})

surface.CreateFont( "Boom_Context_Menu_Font3", {   font = "Roboto",    size = Hss * 25,  weight = 1500,   blursize = 0,   scanlines = 0,  antialias = true,} )

-- HUD
net.Receive("SendSpawnReceiveClient",function()

	Tick = true

end)

hook.Add( "HUDPaint", "SimpleHud", function()

    local food = LocalPlayer():getDarkRPVar("Energy")
    local health = LocalPlayer():Health()
    if health < 0 then health = 0 elseif health > 100 then health = 100 end 
    local armor = LocalPlayer():Armor()
    if armor < 0 then armor = 0 elseif armor > 100 then armor = 100 end
    if armor !=0 then 
    
    draw.RoundedBox(0, 5*Wss, 1000*Hss, 200*Wss, 20*Hss, Color(0,0,0,160))
    draw.RoundedBox(0, 6*Wss, 1001*Hss, armor * ( 1.98*Wss) , 17*Hss, Color(37, 94, 215, 255)) -- armure

 end
    
    local wep = LocalPlayer():GetActiveWeapon()

    if(IsValid(wep) && wep:Clip1() != -1 ) then
        
        draw.RoundedBox(0, 1820*Wss, 1045*Hss, 100*Wss, 30*Hss, Color(0,0,0,180 ))
        draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1().." / "..LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "lss_1", 1870*Hss, 1050*Hss, Color(255, 255, 255), TEXT_ALIGN_CENTER)
   
   end

draw.RoundedBox(0, 5*Wss, 1025*Hss, 200*Wss, 20*Hss, Color(0,0,0,160))
draw.RoundedBox(0, 6*Wss, 1026*Hss, health * ( 1.98*Wss) , 17*Hss, Color(225, 45, 45, 255)) -- vie

draw.RoundedBox(0, 5*Wss, 1052*Hss, 200*Wss, 20*Hss, Color(0, 0, 0, 160))
draw.RoundedBox(0, 6*Wss, 1053, food * ( 1.98*Wss ), 17*Hss, Color(81, 202, 81, 255)) -- food

draw.RoundedBox(0, 20*Wss, 10*Hss, 200*Wss, 25*Hss, Color(50, 50, 50, 150))
draw.SimpleText("Vous "..etatspeak.." [F2]", "Boom_Context_Menu_Font3", 120*Hss, 10*Hss, Color(26, 43, 233, 200), TEXT_ALIGN_CENTER)
draw.RoundedBox(0, 225*Wss, 10*Hss, 150*Wss, 25*Hss, Color(50, 50, 50, 150))
draw.SimpleText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")),"Boom_Context_Menu_Font3",300*Hss, 10*Hss,Color(26, 43, 233, 200), TEXT_ALIGN_CENTER)


end)

--Ancien HUD
local HideElements = { "DarkRP_HUD", "DarkRP_LocalPlayerHUD", "DarkRP_EntityDisplay", "DarkRP_Agenda", "DarkRP_Hungermod" }
 
local disable = {
CHudHealth = true,
CHudBattery = true,
CHudAmmo = true,
CHudSecondaryAmmo = true,
DarkRP_HUD = true,
DarkRP_Hungermod = true,
}
 
hook.Add( 'HUDShouldDraw', 'Inumix:HUD:HideDefault', function( object )
if ( disable[ object ] ) then
return false
end
end )


if delay == nil then
    delay = 0
end

if etatspeak == nil then
	etatspeak = "parlez"
end

hook.Add("Think","KeyPressF6Montre", function()

    if CurTime() < delay then

        return
    end



	if input.IsKeyDown(KEY_F2) then
		if etatspeak == "chuchotez" then
			etatspeak = "parlez"
	        net.Start("ModeParler2")
         	net.SendToServer()
		elseif etatspeak == "parlez" then
			etatspeak = "criez"
	        net.Start("ModeCrier2")
	        net.SendToServer()
		elseif etatspeak == "criez" then
			etatspeak = "chuchotez"
	        net.Start("ModeChucho2")
            net.SendToServer()
		end

		print(etatspeak)
		delay = CurTime() + 0.5
	end


end)