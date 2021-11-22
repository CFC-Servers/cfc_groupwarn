util.AddNetworkString "CFC_GroupCheck_BannedGroupMembers"

class Alerter
    @alertRanks:
        sentinel: true
        moderator: true

    shouldAlert: (ply) =>
        return true if ply\IsAdmin!
        return true if @@alertRanks[ply\GetUserGroup!]
        false

    getPlayersToAlert: => [p for p in *player.GetAll! when @shouldAlert p]

    alert: (ply, count) =>
        net.Start "CFC_GroupCheck_BannedGroupMembers"
        net.WriteEntity ply
        net.WriteUInt 14, count
        net.Send @getPlayersToAlert!

GroupCache.Alerter = Alerter!
