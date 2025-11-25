import Config

config :useless_machine, ecto_repos: [Journey.Repo]

config :journey, Journey.Repo,
  database: "useless_machine",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :logger,
       :console,
       format: "$time [$level] $metadata$message\n",
       level: :warning,
       metadata: [:pid, :mfa]

config :journey, :graphs, [
  &UselessMachine.graph/0
]
