local pp = require 'lib.pp'
local test = require 'lib.u-test'
local ECS = require 'src.ecs'

test.ecs.should_load_a_component = function()
  local ecs = ECS()
  local component = ecs:load_component('transform')

  test.is_not_nil(component)
  test.equal(component.position.x, 0)
  test.equal(component.position.y, 0)
  test.equal(component.position.z, 0)
end

test.ecs.should_load_a_component_as_array = function()
  local ecs = ECS()
  local component = ecs:load_component('color')

  test.is_not_nil(component)
  test.equal(component[1], 1)
  test.equal(component[2], 1)
  test.equal(component[3], 1)
  test.equal(component[4], 1)
end

test.ecs.should_load_a_state = function()
  local ecs = ECS()
  local state = ecs:load_state('boot')

  test.is_not_nil(state)
  test.equal(state.id, 'boot')
  test.equal(#state.system, 3)
  test.equal(#state.entity.player, 1)
end

test.ecs.should_change_the_current_state = function()
end