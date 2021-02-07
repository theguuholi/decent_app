defmodule DecentApp.Core do
  alias DecentApp.Core.Validation

  defp new_balance(true, _, _, _), do: {nil, nil, true}

  defp new_balance(false, bal, command, res) do
    new_balance = %{bal | coins: bal.coins - 1}
    IO.inspect res
    res =
      cond do
        command === "NOTHING" ->
          res

        true ->
          cond do
            command == "DUP" ->
              res ++ [List.last(res)]

            true ->
              if command == "POP" do
                {_, res} = List.pop_at(res, length(res) - 1)
                res
              else
                cond do
                  command == "+" ->
                    [first, second | rest] = Enum.reverse(res)
                    Enum.reverse(rest) ++ [first + second]

                  command == "-" ->
                    [first, second | rest] = Enum.reverse(res)
                    Enum.reverse(rest) ++ [first - second]

                  is_integer(command) ->
                    res ++ [command]

                  command == "COINS" ->
                    res
                end
              end
          end
      end

    new_balance =
      if command == "COINS" do
        %{new_balance | coins: new_balance.coins + 6}
      else
        new_balance
      end

    new_balance =
      if command == "+" do
        %{new_balance | coins: new_balance.coins - 1}
      else
        new_balance
      end

    {new_balance, res, false}
  end

  def bla(bal, res, command) do
    Validation.is_valid?(res, command)
    |> new_balance(bal, command, res)
  end
end
