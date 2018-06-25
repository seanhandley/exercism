defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when is_integer(code) do
    Enum.reduce(_commands(), [], fn {k, f}, acc ->
      cond do
        band(code, k) == k -> f.(acc)
        true -> acc
      end
    end)
  end

  defp _commands do
    %{
      1 => fn acc -> acc ++ ["wink"] end,
      2 => fn acc -> acc ++ ["double blink"] end,
      4 => fn acc -> acc ++ ["close your eyes"] end,
      8 => fn acc -> acc ++ ["jump"] end,
      16 => fn acc -> Enum.reverse(acc) end
    }
  end
end
