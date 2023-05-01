import_if_available Plug.Conn
import_if_available Phoenix.HTML
import_if_available Ecto.Query
import_if_available Ecto.Changeset
alias Ecto.Changeset
alias Pulse.Repo

Application.put_env(:elixir, :ansi_enabled, true)

# Change behavior of dbg/1 to stop prying when in IEx
Application.put_env(:elixir, :dbg_callback, {Macro, :dbg, []})

IEx.configure [
  default_prompt: "%prefix>",
  alive_prompt: "%prefix(%node)>",
  history_size: -1,
  inspect: [
    pretty: true,
    limit: 10_000,
    printable_limit: 10_000,
    binaries: :as_strings,
    charlists: :as_lists,
    width: 120
  ],
  colors: [
    eval_result: [ :green, :bright ],
    eval_result: [ :red, :bright ],
    eval_info:   [ :cyan ],
  ]
]

is_elixir_module? = fn module ->
  case module do
    "Elixir." <> _ -> true
    _ -> false
  end
end
