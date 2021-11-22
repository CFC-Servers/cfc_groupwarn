import concat from table
import Compress, Decompress from util

class Cacher
    @separator: ","

    new: =>
        @cache = {}

    get: (steamID64) =>
        cached = @cache[steamID64]
        return unless cached

        Split Decompress(cached), @@separator

    set: (steamID64, groups) =>
        groups = Compress concat groups, @@separator
        @cache[steamID64] = groups

GroupCheck.Cache = Cacher!
