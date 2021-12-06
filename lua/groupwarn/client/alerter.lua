local YELLOW = Color(250, 250, 0)
local RED = Color(250, 0, 0)
local WHITE = Color(250, 250, 250)
local GREY = Color(100, 100, 100)
local LIGHTBLUE = Color(58, 188, 230)
return net.Receive("CFC_GroupCheck_BannedGroupMembers", function()
  local ply = net.ReadEntity()
  if not (IsValid(ply)) then
    return 
  end
  local count = tostring(net.ReadUInt(14))
  local name = ply:Nick()
  local steamID = ply:SteamID()
  return chat.AddText(LIGHTBLUE, "[Staff] ", YELLOW, "[Warning] ", WHITE, "The players from ", YELLOW, name, GREY, "(", WHITE, steamID, GREY, ")", WHITE, "'s Steam Groups have been banned ", RED, count, WHITE, " times!")
end)
