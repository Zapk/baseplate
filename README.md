# baseplate
A set of essential libraries for working with [Blockland Lua](https://github.com/portify/BlocklandLua).

Make sure you have the BlocklandLua DLL injected, place everything here (except for README.md) in Blockland/, and do
```Lua
require('baseplate')
```

##clients.lua
Library for handling Blockland clients with Lua.

```Lua
clients.GetAll() -- returns a table of all clients.
clients.GetByBLID(blid) -- returns the client with that blid, or nil
clients.GetByName(name) -- returns the client with that name, or nil

--[[string]]   Client:GetName()
--[[number]]   Client:GetBLID()
--[[void]]     Client:InstantRespawn()
--[[void]]     Client:Play2D( string profileName )
--[[void]]     Client:Play3D( string profileName, vector pos )
--[[void]]     Client:SetScore( number amount )
--[[void]]     Client:IncScore( number amount )
```
####Example:
```Lua
local client = clients.GetByName('Zapk')

print(client:GetName()) -- Zapk
print(client:GetBLID()) -- 44868
client:Play3D('AlarmSound', Vector(6, 2, 3)) -- Plays them 'AlarmSound' at pos '6 2 3'.

for _, v in pairs( clients.GetAll() ) do
   if v == client then
      print(v:GetName()) -- Zapk
      print(v:GetBLID()) -- 44868
   end
end
```

##players.lua
Library for handling Blockland players with Lua.

```Lua
--[[bool]]     Client:HasPlayer()
--[[player]]   Client:GetPlayer()

--[[bool]]     Player:HasClient()
--[[client]]   Player:GetClient()
--[[vector]]   Player:GetPosition()
--[[void]]     Player:SetPosition( vector pos )
--[[vector]]   Player:GetVelocity()
--[[void]]     Player:SetVelocity( vector vel )
--[[void]]     Player:Kill()
```
####Example:
```Lua
local client = clients.GetByName('Zapk')
local player = nil

if not client:HasPlayer() then return end
player = client:GetPlayer()

print( tostring( player:GetVelocity() ) ) -- 0 0 0
player:SetVelocity( Vector( 2, 4, 6 ) )
print( tostring( player:GetVelocity() ) ) -- 2 4 6

player:Kill()
```

##commands.lua
Library for handling client commands and messages easily with Lua.

```Lua
--[[void]]     Client:SendCommand( string cmd, ... )
--[[void]]     BroadcastCommand( string cmd, ... )
--[[void]]     Client:SendMessage( string tag, ... )
--[[void]]     BroadcastMessage( string tag, ... )
```
####Example:
```Lua
local client = clients.GetByName('Zapk')

client:SendCommand('MsgBoxOK', 'Hello', 'Just click "OK" please.') -- Sends a client command to the client.
client:SendMessage('', '\x07This is white, ' .. client:GetName() .. '!') -- Sends a message to the client.

BroadcastMessage('MsgAdminForce', '\x03Mr Queeba has become Super Admin (Auto)') -- Sends a message to all clients.
```

##vector.lua
Library for vectors that are easier to work with than Torque's. Similar to [Garry's Mod](http://wiki.garrysmod.com/page/Category:Vector).

```Lua
--[[void]]     Vector:Add( Vector other )
--[[void]]     Vector:Sub( Vector other )
--[[vector]]   Vector:Cross( Vector other )
--[[number]]   Vector:Distance( Vector other )
--[[number]]   Vector:Dot( Vector other )
--[[number]]   Vector:Length()
--[[void]]     Vector:Normalize()

tostring( Vector(1, 2, 3) ) -- returns "1 2 3"
```
You can also use operators on vectors to get results.
```Lua
Vector(1, 0, 1) + Vector(1, 0, 0) -- is the same as Vector(2, 0, 1)
Vector(1, 0, 1) - Vector(1, 0, 0) -- is the same as Vector(0, 0, 1)
Vector(1, 0, 1) / 2 -- is the same as Vector(0.5, 0, 0.5)
Vector(1, 0, 1) * 2 -- is the same as Vector(2, 0, 2)
Vector(1, 0, 1) ^ 2 -- is the same as Vector(1, 0, 1) - exponential, 1 squared is 1 :P
```
####Example:
```Lua
local vec = Vector(5, 10, 15)

print(tostring(vec)) -- 5 10 15
print(vec.x) -- 5
print(vec.y) -- 10
print(vec.z) -- 15

vec:Add( Vector(5, 0, 0) ) -- adds to the vector itself
print(tostring()) -- 10 10 15
```

##meta.lua
Simple library for working with important meta tables (such as Client, Player, Vector).
####Example:
```Lua
local clientMeta = FindMetaTable( "Client" )
function clientMeta:IsAClient()
   if self:GetName() == "Zapk" then
      return "Yup."
   else
      return "Barely."
   end
end

local client = clients.GetByName('Zapk')
print(client:IsAClient()) -- Yup.

```

##timer.lua
Simple timer library that hooks into Torque schedules.
####Example:
```Lua
local test = timer.Create( 1000, function()
   print('Hello!')
end )
-- Will print 'Hello!' in 1000 milliseconds.

if timer.Exists(test) then
   timer.Cancel(test)
   -- Not anymore, it won't.
end
```

##console.lua
Allows typing ".`myCode`" in the Blockland console to run "`myCode`" as Lua. This is just raw TorqueScript using `ts.eval()` for simplicity
