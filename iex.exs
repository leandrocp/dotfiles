IEx.configure history_size: -1

IEx.configure default_prompt: "%prefix>"
IEx.configure alive_prompt: "%prefix(%node)>"

IEx.configure colors: [
  eval_result: [ :green, :bright ],
  eval_result: [ :red, :bright ],
  eval_info:   [ :cyan ],
]
