defmodule UselessMachineTest do
  use ExUnit.Case
  doctest UselessMachine

  @keep_trying_times 10

  test "useless machine" do
    # Start a new execution of the Useless Machine graph.
    execution =
      UselessMachine.graph()
      |> Journey.start()

    # :switch has yet to be set.
    assert {:error, :not_set} == Journey.get(execution, :switch)

    # :paw has yet to spring into action...
    assert {:error, :not_set} == Journey.get(execution, :paw)

    # Let's turn it on, and see what happens.
    turn_on_watch_it_turn_itself_off(execution.id, 0, 1)
  end

  defp turn_on_watch_it_turn_itself_off(_, _, retry_count) when retry_count > @keep_trying_times, do: :ok

  defp turn_on_watch_it_turn_itself_off(execution_id, last_paw_revision, retry_count) do
    # Load the execution by its id (as we might after a crash or a restart or a redeployment,
    # or when the user returns after a break, or just reloads the web page).
    execution = Journey.load(execution_id)

    if retry_count > 1 do
      # We should be starting in the "off" position.
      {:ok, current_switch_value, _} = Journey.get(execution, :switch)
      assert current_switch_value == "off"
    end

    # Turn the :switch on.
    IO.puts("turning on! (attempt #{retry_count}/#{@keep_trying_times})")
    _execution = Journey.set(execution, :switch, "on")

    # Watch the :paw wake up...
    {:ok, "updated :switch", new_paw_revision} = Journey.get(execution, :paw, wait: {:newer_than, last_paw_revision})
    assert new_paw_revision > last_paw_revision

    # ... and promptly turn the :switch off:
    {:ok, new_switch_position, _} = Journey.get(execution, :switch, wait: :any)
    assert new_switch_position == "off"
    IO.puts("the switch is now off!")
    IO.puts("---")

    # Let's try again, maybe?
    turn_on_watch_it_turn_itself_off(execution.id, new_paw_revision, retry_count + 1)
  end
end
