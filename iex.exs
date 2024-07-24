import_if_available(Plug.Conn)
import_if_available(Phoenix.HTML)
import_if_available(Ecto.Query)
import_if_available(Ecto.Changeset)

IEx.configure(
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
)