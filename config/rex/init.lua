-- Ctrl+B is a tmux-style prefix. Rex key sequences use `>` between keys.
-- Press Ctrl+B twice to send Ctrl+B through to the focused terminal.
local leader = "ctrl+b>"

-- Pane focus: Ctrl+B, then h/j/k/l
rex.bind(leader .. "h", "pane.focus.left")
rex.bind(leader .. "j", "pane.focus.down")
rex.bind(leader .. "k", "pane.focus.up")
rex.bind(leader .. "l", "pane.focus.right")

-- Pane resize: Ctrl+B, then Shift+h/j/k/l
rex.bind(leader .. "shift+h", "pane.resize", { direction = "left", amount = 5 })
rex.bind(leader .. "shift+j", "pane.resize", { direction = "down", amount = 5 })
rex.bind(leader .. "shift+k", "pane.resize", { direction = "up", amount = 5 })
rex.bind(leader .. "shift+l", "pane.resize", { direction = "right", amount = 5 })

-- Layout
rex.bind(leader .. "v", "pane.split.right")
rex.bind(leader .. "s", "pane.split.down")
rex.bind(leader .. "z", "pane.zoom")
rex.bind(leader .. "=", "pane.balance")
rex.bind(leader .. "x", "pane.close")

-- Tabs
rex.bind(leader .. "n", "client.tab.new")
rex.bind(leader .. "[", "client.tab.previous")
rex.bind(leader .. "]", "client.tab.next")
rex.bind(leader .. "r", "client.tab.rename")

-- Rex controls
rex.bind(leader .. "p", "client.palette.toggle")
rex.bind(leader .. "ctrl+b", "pane.send_key", { key = "ctrl+b" })
