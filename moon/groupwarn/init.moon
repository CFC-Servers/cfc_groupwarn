if SERVER
    AddCSLuaFile "client/alerter.lua"
    include "server/init.lua"
else
    include "client/alerter.lua"
