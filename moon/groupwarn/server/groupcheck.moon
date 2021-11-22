import SteamIDTo64 from util

hook.Add "InitPostEntity", "CFC_GroupCheck_StorageSetup", GroupCheck.Storage\Setup

hook.Add "ULibPlayerBanned", "CFC_GroupCheck", (steamID) ->
    steamID64 = SteamIDTo64 steamID
    groups = GroupCheck.Cache\get steamID64

    GroupCheck.Storage\AddTotals groups

hook.Add "PlayerAuthed", "CFC_GroupCheck", (ply, steamID) ->
    steamID64 = SteamIDTo64 steamID
    return if GroupCheck.Cache\get steamID64

    GroupCheck.Checker\checkGroups ply
