YELLOW = Color 250, 250, 0
RED = Color 250, 0, 0
WHITE = Color 250, 250, 250
GREY = Color 100, 100, 100
LIGHTBLUE = Color 58, 188, 230

net.Receive "CFC_GroupCheck_BannedGroupMembers", ->
    ply = net.ReadEntity!
    count = tostring net.ReadUInt 14

    name = ply\Nick!
    steamID = ply\SteamID!

    chat.AddText LIGHTBLUE, "[Staff] ", YELLOW, "[Warning] ", WHITE, "The players from ", YELLOW, name, GREY, "(", WHITE, steamID, GREY, ")", WHITE, "'s Steam Groups have been banned ", RED, count, WHITE, " times!"
