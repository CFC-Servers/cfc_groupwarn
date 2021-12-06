if SERVER then
  AddCSLuaFile("client/alerter.lua")
  return include("server/init.lua")
else
  return include("client/alerter.lua")
end
