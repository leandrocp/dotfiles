-- Ctrl+B is a tmux-style prefix. Rex key sequences use `>` between keys.
-- Press Ctrl+B twice to send Ctrl+B through to the focused terminal.
local leader = "ctrl+b>"

-- Pane focus: Ctrl+B, then h/j/k/l.
rex.bind(leader .. "h", "pane.focus.left")
rex.bind(leader .. "j", "pane.focus.down")
rex.bind(leader .. "k", "pane.focus.up")
rex.bind(leader .. "l", "pane.focus.right")

-- Pane movement: Ctrl+B, then Shift+h/j/k/l.
rex.bind(leader .. "shift+h", "pane.move.left")
rex.bind(leader .. "shift+j", "pane.move.down")
rex.bind(leader .. "shift+k", "pane.move.up")
rex.bind(leader .. "shift+l", "pane.move.right")

-- Resize mode: Ctrl+B, r, then h/j/k/l. Shift resizes in larger steps.
rex.mode("resize", { exclusive = true })
rex.bind(leader .. "r", "client.mode.enter", { name = "resize" })
rex.bind("resize/h", "pane.resize", { direction = "left" })
rex.bind("resize/j", "pane.resize", { direction = "down" })
rex.bind("resize/k", "pane.resize", { direction = "up" })
rex.bind("resize/l", "pane.resize", { direction = "right" })
rex.bind("resize/shift+h", "pane.resize", { direction = "left", amount = 15 })
rex.bind("resize/shift+j", "pane.resize", { direction = "down", amount = 15 })
rex.bind("resize/shift+k", "pane.resize", { direction = "up", amount = 15 })
rex.bind("resize/shift+l", "pane.resize", { direction = "right", amount = 15 })
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")

-- Layout. Keep readable v/s bindings and tmux's %/" aliases.
rex.bind(leader .. "v", "pane.split.right")
rex.bind(leader .. "s", "pane.split.down")
rex.bind(leader .. "shift+5", "pane.split.right")
rex.bind(leader .. "shift+'", "pane.split.down")
rex.bind(leader .. "z", "pane.zoom")
rex.bind(leader .. "=", "pane.balance")
rex.bind(leader .. "x", "pane.close")

-- Tabs.
rex.bind(leader .. "c", "client.tab.new")
rex.bind(leader .. "n", "client.tab.next")
rex.bind(leader .. "p", "client.tab.previous")
rex.bind(leader .. "[", "client.tab.previous")
rex.bind(leader .. "]", "client.tab.next")
rex.bind(leader .. ",", "client.tab.rename")
rex.bind(leader .. "q>t", "client.tab.close")

for index = 1, 9 do
  rex.bind(leader .. tostring(index), "client.tab.goto", { index = index })
end

-- Sessions.
rex.bind(leader .. "w", "session.switch")
rex.bind(leader .. "shift+9", "session.previous")
rex.bind(leader .. "shift+0", "session.next")
rex.bind(leader .. "shift+4", "session.rename")
rex.bind(leader .. "q>s", "session.close")

-- Rex controls.
rex.bind(leader .. "space", "client.palette.toggle")
rex.bind(leader .. "ctrl+b", "pane.send_key", { key = "ctrl+b" })
