local present, ss = pcall(require, "smart-splits")

if not present then
  return
end

ss.setup({
  tmux_integration = false
})


