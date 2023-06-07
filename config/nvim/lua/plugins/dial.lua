return {
  "monaqa/dial.nvim",
  keys = {
    {
      "<C-a>",
      function()
        return require("dial.map").inc_normal()
      end,
      expr = true,
    },
    {
      "<C-x>",
      function()
        return require("dial.map").dec_normal()
      end,
      expr = true,
    },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.case.new({
          types = { "camelCase", "PascalCase", "snake_case", "SCREAMING_SNAKE_CASE" },
        }),
        augend.constant.new({
          elements = { "let", "const" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "and", "or" },
          word = false,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "on", "off" },
          word = false,
          cyclic = true,
        }),
      },
    })
  end,
}
