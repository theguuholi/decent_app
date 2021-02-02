defmodule DecentApp.Core.Validation do

  def valid_command?("DUP"), do: true
  def valid_command?("POP"), do: true
  def valid_command?("+"), do: true
  def valid_command?("-"), do: true
  def valid_command?(_), do: false

  def is_valid?(res, command) do
    cond do
      length(res) < 1 ->
        valid_command?(command)

      length(res) < 2 ->
        ((command == "+" || command == "-") && true) || false

      is_integer(command) ->
        ((command < 0 || command > 10) && true) || false

      command not in ["NOTHING", "DUP", "POP", "+", "-", "COINS"] && !is_integer(command) ->
        true

      true ->
        false
    end
  end
end
