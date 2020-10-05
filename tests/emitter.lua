local test = require 'lib.u-test'
local Emitter = require 'src.emitter'

test.emitter.should_emit_an_event = function()
  local count = 0
  local emitter = Emitter()

  emitter:on('inc', function()
    count = count + 1
  end)

  emitter:on('dec', function()
    count = count - 1
  end)

  emitter:emit('inc')
  test.equal(count, 1)

  emitter:emit('dec')
  test.equal(count, 0)
end