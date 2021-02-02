defmodule DecentApp.Core do
  alias DecentApp.Core.Validation
  def bla(bal, res, command) do
    is_error = Validation.is_valid?(res, command)

    if is_error do
      {nil, nil, true}
    else
      new_balance = %{bal | coins: bal.coins - 1}

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
  end
end
