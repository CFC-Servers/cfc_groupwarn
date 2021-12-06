local SteamIDTo64
SteamIDTo64 = util.SteamIDTo64
hook.Add("InitPostEntity", "CFC_GroupCheck_StorageSetup", (function()
  local _base_0 = GroupCheck.Storage
  local _fn_0 = _base_0.Setup
  return function(...)
    return _fn_0(_base_0, ...)
  end
end)())
hook.Add("ULibPlayerBanned", "CFC_GroupCheck", function(steamID)
  local steamID64 = SteamIDTo64(steamID)
  local groups = GroupCheck.Cache:get(steamID64)
  return GroupCheck.Storage:AddTotals(groups)
end)
return hook.Add("PlayerAuthed", "CFC_GroupCheck", function(ply, steamID)
  local steamID64 = SteamIDTo64(steamID)
  if GroupCheck.Cache:get(steamID64) then
    return 
  end
  return GroupCheck.Checker:checkGroups(ply)
end)
