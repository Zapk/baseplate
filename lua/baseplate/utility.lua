function isboolean(any)
  return type(any) == "boolean"
end

function isnumber(any)
  return type(any) == "number"
end

function isstring(any)
  return type(any) == "string"
end

function isfunction(any)
  return type(any) == "function"
end

function CurTime()
  return tonumber(con.getSimTime()) / 1000
end

function RealTime()
  return tonumber(con.getRealTime()) / 1000
end
