import SteamIDTo64 from util
import format, gmatch from string

class Checker
    @groupPattern: "<groupID64>(%d+)</groupID64>"
    @urlTemplate: "https://steamcommunity.com/profiles/%s?xml=true"

    new: =>
        @Cache = GroupCheck.Cache
        @Storage = GroupCheck.Storage
        @Alerter = GroupCheck.Alerter

    checkGroups: (ply, groups) =>
        counts = @Storage\GetCounts groups
        total = 0

        for _, count in pairs counts
            total += count

        return if total ==0

        @Alerter\alert ply, totals

    getGroupsForPlayer: (steamID64, cb) =>
        steamid = SteamIDTo64 steamID64
        url = format urlTemplate, steamID64

        success = (body) ->
            groups = {}

            for v in *gmatch body, pattern
                -- FIXME: Figure out what this actually looks like
                print v
                PrintTable v if istable v

            @Cache\set steamID64, groups

        http.Fetch url, success

GroupCheck.Checker = Checker!
