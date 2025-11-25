defmodule UselessMachineTest do
  use ExUnit.Case
  doctest UselessMachine

  test "get the graph" do
    assert UselessMachine.graph() != nil
  end
end
