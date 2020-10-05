local Input = require 'src.module.input'
local Window = require 'src.module.window'
local System = require 'src.module.system'
local Core = require 'src.core'

function love.load()
  Core:load()
  Core:change_state('boot')
end

function love.update(dt)
  Core:update(dt)
end

function love.draw()
  Core:draw()
end

--

function love.keypressed(...)
  Input:emit('key_pressed', ...)
end

function love.keyreleased(...)
  Input:emit('key_released', ...)
end

function love.mousepressed(...)
  Input:emit('mouse_pressed', ...)
end

function love.mousereleased(...)
  Input:emit('mouse_released', ...)
end

function love.textinput(...)
  Input:emit('text_input', ...)
end

function love.textedited(...)
  Input:emit('text_edited', ...)
end

function love.wheelmoved(...)
  Input:emit('wheelmoved', ...)
end

function love.mousemoved(...)
  Input:emit('mouse_moved', ...)
end

--

function love.focus(...)
  Window:emit('focus', ...)
end

function love.quit(...)
  Window:emit('quit', ...)
end

function love.resize(...)
  Window:emit('resize', ...)
end

function love.visible(...)
  Window:emit('visible', ...)
end

function love.filedropped(...)
  Window:emit('file_dropped', ...)
end

function love.directorydropped(...)
  Window:emit('directory_dropped', ...)
end

--

function love.threaderror(...)
  System:emit('thread_error', ...)
end

function love.lowmemory(...)
  System:emit('low_memory', ...)
end
