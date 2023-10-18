return {
  "tpope/vim-projectionist",
  event = "BufReadPost",
  init = function()
    vim.g.projectionist_heuristics = {
      ["package.json"] = {
        ["package.json"] = { alternate = { "package-lock.json" } },
        ["package-lock.json"] = { alternate = { "package.json" } },
      },
      -- TODO: managed by elixir-tools
      -- ["mix.exs"] = {
      --   ["mix.exs"] = { alternate = { "mix.lock" } },
      --   ["mix.lock"] = { alternate = { "mix.exs" } },
      --   ["lib/*.ex"] = {
      --     type = "source",
      --     alternate = "test/{}_test.exs",
      --     template = {
      --       "defmodule {camelcase|capitalize|dot} do",
      --       "end",
      --     },
      --   },
      --   ["test/*_test.exs"] = {
      --     type = "test",
      --     alternate = "lib/{}.ex",
      --     template = {
      --       "defmodule {camelcase|capitalize|dot}Test do",
      --       "  use ExUnit.Case, async: true",
      --       "",
      --       "  alias {camelcase|capitalize|dot}",
      --       "end",
      --     },
      --   },
      -- },
    }
  end,
}
