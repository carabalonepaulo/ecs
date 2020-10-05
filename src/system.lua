local utils = require 'lib.utils'
local pp = require 'lib.pp'
local Core = require 'src.core'
local Object = require 'lib.object'
local System = Object:extend()

function System:new(state)
  self.state = state
end

function System:change_state(state_id)
  Core:change_state(state_id)
end

function System:get_state()
  return self.state
end

function System:get_entity(template_name, id)
  return self.state:get_entity(template_name, id)
end

function System:get_entities(template_name)
  return self.state:get_entities(template_name)
end

function System:load()
end

function System:unload()
end

function System:update(dt)
end

function System:draw()
end

return System