defmodule UselessMachineTest do
  use ExUnit.Case
  doctest UselessMachine

  test "greets the world" do
    assert UselessMachine.hello() == :world
  end
end
