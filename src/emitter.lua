local f = require 'lib.fun'
local Object = require 'lib.object'
local Emitter = Object:extend()

function Emitter:new()
  self.events = {}
  self.callback_counter = {}
end

function Emitter:emit(event, ...)
  if not self.events or not self.events[event] then
    return
  end

  local arg = {...}
  f.each(function(callback)
    callback(unpack(arg))
  end, self.events[event])
end

function Emitter:on(event, callback)
  if not self.events then
    self.events = { [event] = {} }
  elseif not self.events[event] then
    self.events[event] = {}
  end

  local len = #self.events[event]
  table.insert(self.events[event], callback)
  return function()
    table.remove(self.events[event], len + 1)
  end
end

return Emitter