local concat
concat = table.concat
local format
format = string.format
local Storage
do
  local _class_0
  local _base_0 = {
    GetTotals = function(self, groupIDs)
      local groups = concat(groupIDs, ", ")
      return sql.Query(format([[            SELECT
                count
            FROM
                cfc_groupcheck_totals
            WHERE
                group_id IN (%s)
        ]], groups))
    end,
    AddTotals = function(self, groupIDs)
      sql.Begin()
      for _index_0 = 1, #groupIDs do
        local id = groupIDs[_index_0]
        sql.Query(format([[                INSERT OR IGNORE INTO
                    cfc_groupcheck_totals (group_id, count)
                VALUES
                    (%s, 0)
            ]], id))
      end
      sql.Query(format([[            UPDATE
                cfc_groupcheck_totals
            SET
                count = count + 1
            WHERE
                group_id IN (%s)
        ]], concat(groupIDs, ", ")))
      return sql.Commit()
    end,
    CreateTable = function(self)
      return sql.Query([[            CREATE TABLE IF NOT EXISTS cfc_groupcheck_totals(
                group_id TEXT        PRIMARY KEY,
                count    INTEGER     NOT NULL DEFAULT 0
            )
        ]])
    end,
    Setup = function(self)
      return self:CreateTable()
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Storage"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Storage = _class_0
end
GroupCheck.Storage = Storage()
