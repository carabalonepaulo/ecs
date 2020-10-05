local State = require 'src.state'
local Object = require 'lib.object'
local Core = Object:extend()

function Core:new()
end

function Core:change_state(state_id)
  if self.state then
    self.state:unload()
    self.state = nil
  end
  self.state = State(state_id)
  self.state:load()
end

function Core:load()
  self.state = nil
end

function Core:update(dt)
  self.state:update(dt)
end

function Core:draw()
  self.state:draw()
end

return Core()