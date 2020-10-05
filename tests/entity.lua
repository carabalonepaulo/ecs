local test = require 'lib.u-test'
local Entity = require 'src.entity'

test.entity.should_init_with_id_and_template = function()
  local entity = Entity('soreto', 'player')

  test.is_not_nil(entity)
  test.equal(entity.id, 'soreto')
  test.equal(entity.template, 'player')
  test.equal(entity:get_component('color')[1], 1)
end

test.entity.should_init_with_id_template_and_default_data = function()
  do
    local entity = Entity('soreto', 'player', {
      color = { .5, 1, 1, 1 }
    })

    test.is_not_nil(entity)
    test.equal(entity.id, 'soreto')
    test.equal(entity.template, 'player')
    test.equal(entity:get_component('color')[1], .5)
  end
end

test.entity.should_return_a_component = function()
end

test.entity.should_return_all_components = function()
end

test.entity.should_return_an_entity = function()
end

test.entity.should_return_all_entities_using_the_template = function()
end

test.entity.should_return_all_entities = function()
end