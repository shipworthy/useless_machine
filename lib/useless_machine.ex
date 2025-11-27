defmodule UselessMachine do
  import Journey.Node

  def graph() do
    Journey.new_graph([
      input(:switch),
      mutate(:paw, [:switch], &lol_no/1, mutates: :switch)
    ])
  end

  defp lol_no(%{switch: switch} = _values) do
    IO.puts("paw says: '#{switch}? lol no'")
    {:ok, "off"}
  end
end
