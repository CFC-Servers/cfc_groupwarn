local concat
concat = table.concat
local Compress, Decompress
do
  local _obj_0 = util
  Compress, Decompress = _obj_0.Compress, _obj_0.Decompress
end
local Split
Split = string.Split
local Cacher
do
  local _class_0
  local _base_0 = {
    get = function(self, steamID64)
      local cached = self.cache[steamID64]
      if not (cached) then
        return 
      end
      return Split(Decompress(cached), self.__class.separator)
    end,
    set = function(self, steamID64, groups)
      groups = Compress(concat(groups, self.__class.separator))
      self.cache[steamID64] = groups
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.cache = { }
    end,
    __base = _base_0,
    __name = "Cacher"
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
  self.separator = ","
  Cacher = _class_0
end
GroupCheck.Cache = Cacher()
