# UselessMachine

[According to Wikipedia](https://en.wikipedia.org/wiki/Useless_machine), a Useless Machine is:
> ... a device whose only function is to turn itself off. The best-known useless machines are those inspired by Marvin Minsky's design, in which the device's sole function is to switch itself off by operating its own "off" switch. Such machines were popularized commercially in the 1960s and sold as an amusing engineering hack or as a joke.


This example illustrates building a Useless Machine with Journey ([hexdocs.pm/journey](https://hexdocs.pm/journey)), a Durable Workflows library.

In this example, as soon as the test sets the `:switch` to "on", `:paw` wakes up (this is the reactivity aspect of Journey) and changes the switch back to "off".

[./lib/useless_machine.ex](./lib/useless_machine.ex) contains the definition of the graph.

```
  ┌─────────────────────────────────────────────┐
  │                                             │
  │  ┌────────────┐             ┌────────────┐  │
  │  │            │ 2. triggers │            │  │
  │  │   :switch  │────────────▶│    :paw    │  │
  │  │   (input)  │             │  (mutate)  │  │
  │  │            │◀────────────│            │  │
  │  └────────────┘ 3. "off"    └────────────┘  │
  │        ▲                                    │
  └────────┼────────────────────────────────────┘
           │ 1. "on"
       ┌───┴───┐
       │ user  │
       └───────┘
```

[./test/useless_machine_test.exs](./test/useless_machine_test.exs) contains a test illustrating the "operation" of the Useless Machine.

This example focuses on the reactive nature of Journey workflows. Journey workflows' durability, crash recovery and scalability features are out of scope for this example.

## Installation

This example uses asdf / `.tool-versions` to manage the versions of Elixir / OTP.

To use it, [install asdf](https://asdf-vm.com/guide/getting-started.html) and asdf plugins for Erlang and Elixir.

Example (on a Mac):

```
$ brew install asdf
$ asdf plugin add erlang
$ asdf plugin add elixir
$ asdf install
```

You will also need to have a database available. If you want to run Postgres in a Docker container, assuming you have Docker installed on your system, here is an example of a command you can use to start a Postgres database server:

```
$ docker run --rm --name pg-useless-machine -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres:16.4
```

To get dependencies and to create the database, run:
```
$ mix deps.get
$ mix ecto.create
$ MIX_ENV=test mix ecto.create
```

## Running tests

As with any Elixir application, you can run tests with `mix test`.

Test output shows the switch being turned on and then the machine itself (the graph's `:paw` node) turning itself off.

```
$ mix test
Running ExUnit with seed: 517447, max_cases: 20

turning on! (attempt 1/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 2/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 3/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 4/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 5/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 6/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 7/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 8/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 9/10)
paw says: 'on? lol no'
the switch is now off!
---
turning on! (attempt 10/10)
paw says: 'on? lol no'
the switch is now off!
---
.
Finished in 5.3 seconds (0.00s async, 5.3s sync)
1 test, 0 failures
```
