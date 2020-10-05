local Object = require 'lib.object'
local File = Object:extend()

function File:new(file_name, mode)
  assert(file_name, 'invalid argument')
  assert(mode, 'invalid argument')

  local file = io.open(file_name, mode)
  assert(file, 'file does not exists')

  self.file = file
end

function File:read_all()
  return self.file:read('a')
end

function File:read_line()
  return self.file:read('l')
end

function File:read_bytes(len)
  assert(type(len) == 'number', 'invalid argument')
  return self.file:read(len)
end

function File:write(data)
  self.file:write(data)
end

function File:write_line(line)
  self.file:write(line..'\n')
end

function File:close()
  self.file:close()
end

-- static

function File.read_all_text(file_name)
  local file = File(file_name, 'r')
  local content = file:read_all()
  if file then
    file:close()
    return content
  else
    error('file does not exists')
  end
end

function File.read_all_bytes(file_name)
  local file = File(file_name, 'rb')
  if file then
    local content = file:read_all()
    file:close()
    return content
  else
    error('file does not exists')
  end
end

function File.write_all_text(file_name, text)
  local file = File(file_name, 'w+')
  file:write(text)
  file:close()
end

function File.write_all_bytes(file_name, buff)
  if File.exists(file_name) then
    File.remove(file_name)
  end

  local file = File(file_name, 'wb')
  file:write(buff)
  file:close()
end

function File.remove(file_name)
  os.remove(file_name)
end

function File.exists(file_name)
  local file = io.open(file_name)
  if file then
    file:close()
    return true
  else
    return false
  end
end

return File