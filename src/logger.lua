local term = require 'lib.plterm'
local Object = require 'lib.object'
local Logger = Object:extend()

local colors = {
  normal = { term.colors.black, term.colors.bgwhite, term.colors.normal },
  debug = { term.colors.white, term.colors.bgblue, term.colors.normal },
  warning = { term.colors.black, term.colors.bgyellow, term.colors.normal },
  danger = { term.colors.white, term.colors.bgred, term.colors.normal },
}

local dir = 'logs'

function Logger:new()
  if not love then
    return
  end

  local info = love.filesystem.getInfo(dir)
  if not info then
    love.filesystem.createDirectory(dir)
  end

  self.file_name = os.date('%d-%m-%Y.txt')
  self.file_path = string.format('logs/%s', self.file_name)
  self.file_instance = love.filesystem.newFile(self.file_path, 'a')
end

function Logger:write_line(level, ...)
  if not love then
    return
  end

  local formated = string.format(...)
  local now = os.date('[%H:%M:%S]')
  local theme = colors[level]
  local reset = { 0, 0 }

  term.color(theme[1], theme[2])
  io.write(now)
  term.color(reset[1], reset[2])
  io.write(string.format(' %s\n', formated))

  self.file_instance:write(string.format('%s %s %s\n', string.upper(level), now, formated ))
end

return Logger()