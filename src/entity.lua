local pp = require 'lib.pp'
local logger = require 'src.logger'
local utils = require 'lib.utils'
local Emitter = require 'src.emitter'
local Entity = Emitter:extend()

function Entity:new(id, template_name, default_data)
  self.id = id
  self.template = template_name
  self.component = {}
  self.entity = {}

  if default_data then
    for k, v in pairs(default_data) do
      self.component[k] = v
    end
  else
    local components = require('game.entity.'..self.template)
    for _, component_id in ipairs(components) do
      local component = require('game.component.'..component_id)
      if type(component) == 'table' then
        self.component[component_id] = utils.deep_copy(component)
      else
        self.component[component_id] = component
      end
    end
  end
end

function Entity:get_component(id)
  return self.component[id]
end

function Entity:get_components()
  return self.component
end

return Entity