local utils = require 'lib.utils'
local Entity = require 'src.entity'
local Emitter  = require 'src.emitter'
local State = Emitter:extend()

local function load_systems(self, system_list)
  for _, system_id in ipairs(system_list) do
    self:add_system(system_id)
  end
end

local function load_entities(self, entity_list)
  for _, entity_data in ipairs(entity_list) do
    local id = entity_data.id
    local template = entity_data.template

    entity_data.id = nil
    entity_data.template = nil

    local entity = Entity(id, template, entity_data)
    if not self.entity[template] then
      self.entity[template] = {}
    end

    self:add_entity(entity)
  end
end

local function load_state(self)
  local state_template = require('game.state.'..self.id)
  load_systems(self, state_template.system)
  load_entities(self, state_template.entity)
end

function State:new(id)
  self.id = id
  self.system = {}
  self.entity = {}

  load_state(self)
end

function State:get_systems()
  return self.system
end

function State:add_system(system_id)
  local system_ctor = require('game.system.'..system_id)
  local system = system_ctor(self)
  table.insert(self.system, system)
end

function State:remove_system(system)
  system:unload()
  table.remove(self.system, utils.find(self.system, system))
end

function State:remove_entity(entity)
  table.remove(self.entity[entity.template], utils.find(self.entity[entity.template], entity))
  self:emit('entity_removed', entity)
end

function State:add_entity(entity)
  table.insert(self.entity[entity.template], entity)
  self:emit('entity_added', entity)
end

function State:get_entity(template, id)
  if not self.entity[template] then
    return nil
  end

  return utils.where(self.entity[template], function(_, entity)
    return entity.id == id
  end)[1]
end

function State:get_entities(template)
  return self.entity[template]
end

function State:load()
  for _, system in ipairs(self.system) do
    system:load()
  end
end

function State:unload()
  for _, system in ipairs(self.system) do
    system:unload()
  end
end

function State:update(dt)
  for _, system in ipairs(self.system) do
    system:update(dt)
  end
end

function State:draw()
  for _, system in ipairs(self.system) do
    system:draw()
  end
end

return State