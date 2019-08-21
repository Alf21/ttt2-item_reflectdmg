if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/icon_reflectdmg.vmt")
	resource.AddFile("materials/vgui/ttt/perks/hud_reflectdmg.png")
end

ITEM.hud = Material("vgui/ttt/perks/hud_reflectdmg.png")
ITEM.EquipMenuData = {
	type = "item_passive",
	name = "ReflectDmg",
	desc = "You can reflect damage by 50%!",
}
ITEM.material = "vgui/ttt/icon_reflectdmg"
ITEM.notBuyable = true
ITEM.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}

if SERVER then
	hook.Add("EntityTakeDamage", "TTTReflectDmg", function(target, dmginfo)
		if not IsValid(target) or not target:IsPlayer() then return end

		if target:IsActive() and target:HasEquipmentItem("item_ttt_reflectdmg") and dmginfo:GetAttacker():IsPlayer() then
			dmginfo:GetAttacker():TakeDamage(dmginfo:GetDamage() * 0.5)
			dmginfo:ScaleDamage(0)
		end
	end)
end
