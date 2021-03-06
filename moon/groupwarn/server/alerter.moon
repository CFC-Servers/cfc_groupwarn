util.AddNetworkString "CFC_GroupCheck_BannedGroupMembers"

class Alerter
    @alertRanks:
        sentinel: true
        moderator: true

    shouldAlert: (ply) =>
        return false if ply\IsPlayer!
        return true if ply\IsAdmin!
        return true if @@alertRanks[ply\GetUserGroup!]
        false

    getPlayersToAlert: => [p for p in *player.GetAll! when @shouldAlert p]

    alert: (ply, count) =>
        net.Start "CFC_GroupCheck_BannedGroupMembers"
        net.WriteEntity ply
        net.WriteUInt count, 14
        net.Send @getPlayersToAlert!

GroupCheck.Alerter = Alerter!
