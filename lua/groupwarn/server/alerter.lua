util.AddNetworkString("CFC_GroupCheck_BannedGroupMembers")
local Alerter
do
  local _class_0
  local _base_0 = {
    shouldAlert = function(self, ply)
      if ply:IsPlayer() then
        return false
      end
      if ply:IsAdmin() then
        return true
      end
      if self.__class.alertRanks[ply:GetUserGroup()] then
        return true
      end
      return false
    end,
    getPlayersToAlert = function(self)
      local _accum_0 = { }
      local _len_0 = 1
      local _list_0 = player.GetAll()
      for _index_0 = 1, #_list_0 do
        local p = _list_0[_index_0]
        if self:shouldAlert(p) then
          _accum_0[_len_0] = p
          _len_0 = _len_0 + 1
        end
      end
      return _accum_0
    end,
    alert = function(self, ply, count)
      net.Start("CFC_GroupCheck_BannedGroupMembers")
      net.WriteEntity(ply)
      net.WriteUInt(count, 14)
      return net.Send(self:getPlayersToAlert())
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Alerter"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.alertRanks = {
    sentinel = true,
    moderator = true
  }
  Alerter = _class_0
end
GroupCheck.Alerter = Alerter()
