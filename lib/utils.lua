local math = require 'math'

local function deep_copy(t)
  local result = {}
  for k, v in pairs(t) do
    local _t = type(v)
    if _t == 'number' or _t == 'string' or _t == 'boolean' then
      result[k] = v
    elseif _t == 'table' then
      result[k] = deep_copy(v)
    end
  end
  return result
end

return {
  each = function(t, callback)
    local iter = #t == 0 and pairs or ipairs
    for key, value in iter(t) do
      callback(key, value)
    end
  end,

  where = function(t, callback)
    local result = {}
    local iter = #t == 0 and pairs or ipairs
    for key, value in iter(t) do
      if callback(key, value) then
        table.insert(result, value)
      end
    end
    return result
  end,

  map = function(t, callback)
    local result = {}
    local iter = #t == 0 and pairs or ipairs
    for key, value in iter(t) do
      table.insert(result, callback(key, value))
    end
    return result
  end,

  to_radians = function(v)
    return v * 0.0174533
  end,

  find = function(t, item)
    for k, v in pairs(t) do
      if item == v then
        return k
      end
    end
    return nil
  end,

  deep_copy = deep_copy,

  pp = require 'lib.pp'
}