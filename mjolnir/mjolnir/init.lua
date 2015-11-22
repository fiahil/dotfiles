local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local screen = require "mjolnir.screen"
local grid = require "mjolnir.bg.grid"

grid.GRIDHEIGHT = 3
grid.GRIDWIDTH = 3
grid.MARGINX = 8
grid.MARGINY = 8

--
-- Aternate grid
--
local alternate = function ()
  if grid.GRIDHEIGHT == 3 or grid.GRIDWIDTH == 3 then
    grid.GRIDHEIGHT = 2
    grid.GRIDWIDTH = 2
    grid.MARGINX = 12
    grid.MARGINY = 12
  else
    grid.GRIDHEIGHT = 3
    grid.GRIDWIDTH = 3
    grid.MARGINX = 8
    grid.MARGINY = 8
  end
end

--
-- Controls Modifiers
-- {alt, cmd}         => size control
-- {alt, cmd, shift}  => super size control
-- {cmd, ctrl}        => position control
--
local size_control = {"alt", "cmd"}
local super_size_control = {"alt", "cmd", "shift"}
local position_control = {"ctrl", "alt"}

--
-- Move a window to the previous/next screen
--
hotkey.bind({"cmd", "alt", "ctrl"}, "right", grid.pushwindow_nextscreen)
hotkey.bind({"cmd", "alt", "ctrl"}, "left", grid.pushwindow_prevscreen)

--
-- Maximize
--
hotkey.bind(size_control, "f", function ()
  window.focusedwindow() : maximize()
end)

hotkey.bind(size_control, "c", function ()
  grid.snap(window.focusedwindow())
end)

--
-- Windows position control
--
hotkey.bind(position_control, "up", grid.pushwindow_up)
hotkey.bind(position_control, "down", grid.pushwindow_down)
hotkey.bind(position_control, "left", grid.pushwindow_left)
hotkey.bind(position_control, "right", grid.pushwindow_right)

--
-- Windows size control
--
hotkey.bind(size_control, "up", grid.resizewindow_shorter)
hotkey.bind(size_control, "down", grid.resizewindow_taller)
hotkey.bind(size_control, "left", grid.resizewindow_thinner)
hotkey.bind(size_control, "right", grid.resizewindow_wider)

hotkey.bind(super_size_control, "left", function ()
  alternate()
  grid.pushwindow_left()
  grid.pushwindow_up()
  grid.resizewindow_taller()
  grid.resizewindow_thinner()
  grid.snap(window.focusedwindow())
  alternate()
end)

hotkey.bind(super_size_control, "right", function ()
  alternate()
  grid.pushwindow_right()
  grid.pushwindow_up()
  grid.resizewindow_taller()
  grid.resizewindow_thinner()
  grid.snap(window.focusedwindow())
  alternate()
end)

hotkey.bind(super_size_control, "up", function ()
  alternate()
  grid.resizewindow_shorter()
  grid.resizewindow_thinner()
  grid.pushwindow_up()
  grid.snap(window.focusedwindow())
  alternate()
end)

hotkey.bind(super_size_control, "down", function ()
  alternate()
  grid.resizewindow_shorter()
  grid.resizewindow_thinner()
  grid.pushwindow_down()
  grid.snap(window.focusedwindow())
  alternate()
end)
