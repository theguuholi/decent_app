defmodule DecentApp do
  alias DecentApp.Balance

  def call(%Balance{} = balance, commands) do
    {balance, result, error} =
      commands
      |> Enum.reduce({balance, [], false}, fn command, {bal, res, error} ->
        IO.inspect res
        IO.inspect command
        is_error?(error, bal, res, command)
      end)

    if error do
      -1
    else
      if balance.coins < 0 do
        -1
      else
        {balance, result}
      end
    end
  end

  def is_error?(true, _, _, _), do: {nil, nil, true}
  def is_error?(false, bal, res, command), do: DecentApp.Core.bla(bal, res, command)
end
