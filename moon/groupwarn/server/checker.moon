import insert from table
import SteamIDTo64 from util
import format, gmatch, Trim from string

class Checker
    @groupPattern: "<groupID64>(%d+)</groupID64>"
    @urlTemplate: "https://steamcommunity.com/profiles/%s?xml=true"

    new: =>
        @Cache = GroupCheck.Cache
        @Storage = GroupCheck.Storage
        @Alerter = GroupCheck.Alerter

    checkGroups: (ply) =>
        steamID64 = ply\SteamID64!
        @getGroupsForPlayer steamID64, (groups) ->
            counts = @Storage\GetTotals groups
            return unless counts

            total = 0

            for entry in *counts
                total += entry.count

            return if total == 0

            @Alerter\alert ply, total

    getGroupsForPlayer: (steamID64, cb) =>
        steamid = SteamIDTo64 steamID64
        url = format @@urlTemplate, steamID64

        success = (body) ->
            groups = {}

            for g in gmatch body, @@groupPattern
                groupID = Trim g

                if #groupID ~= 18
                    ErrorNoHaltWithStack "Got an invalid Group ID: ", g
                    continue

                insert groups, groupID

            @Cache\set steamID64, groups
            cb groups

        http.Fetch url, success

GroupCheck.Checker = Checker!
