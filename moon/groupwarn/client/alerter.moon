YELLOW = Color 180, 180, 0
RED = Color 180, 0, 0
WHITE = Color 180, 180, 180

net.Receive "CFC_GroupCheck_BannedGroupMembers", ->
    ply = net.ReadEntity!
    count = net.ReadUInt 14

    name = ply\Nick!
    steamID = ply\SteamID!
    plyLine = "#{name} (#{steamID})"
    chat.AddText YELLOW, "The players from ", WHITE, plyLine, YELLOW,
                 "'s Steam Groups have been banned ", RED, count, YELLOW " times on CFC!"
