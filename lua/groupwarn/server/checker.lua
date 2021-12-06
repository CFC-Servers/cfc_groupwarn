local insert
insert = table.insert
local SteamIDTo64
SteamIDTo64 = util.SteamIDTo64
local format, gmatch, Trim
do
  local _obj_0 = string
  format, gmatch, Trim = _obj_0.format, _obj_0.gmatch, _obj_0.Trim
end
local Checker
do
  local _class_0
  local _base_0 = {
    checkGroups = function(self, ply)
      local steamID64 = ply:SteamID64()
      return self:getGroupsForPlayer(steamID64, function(groups)
        local counts = self.Storage:GetTotals(groups)
        if not (counts) then
          return 
        end
        local total = 0
        for _index_0 = 1, #counts do
          local entry = counts[_index_0]
          total = total + entry.count
        end
        if total == 0 then
          return 
        end
        return self.Alerter:alert(ply, total)
      end)
    end,
    getGroupsForPlayer = function(self, steamID64, cb)
      local steamid = SteamIDTo64(steamID64)
      local url = format(self.__class.urlTemplate, steamID64)
      local success
      success = function(body)
        local groups = { }
        for g in gmatch(body, self.__class.groupPattern) do
          local _continue_0 = false
          repeat
            local groupID = Trim(g)
            if #groupID ~= 18 then
              ErrorNoHaltWithStack("Got an invalid Group ID: ", g)
              _continue_0 = true
              break
            end
            insert(groups, groupID)
            _continue_0 = true
          until true
          if not _continue_0 then
            break
          end
        end
        self.Cache:set(steamID64, groups)
        return cb(groups)
      end
      return http.Fetch(url, success)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.Cache = GroupCheck.Cache
      self.Storage = GroupCheck.Storage
      self.Alerter = GroupCheck.Alerter
    end,
    __base = _base_0,
    __name = "Checker"
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
  self.groupPattern = "<groupID64>(%d+)</groupID64>"
  self.urlTemplate = "https://steamcommunity.com/profiles/%s?xml=true"
  Checker = _class_0
end
GroupCheck.Checker = Checker()
