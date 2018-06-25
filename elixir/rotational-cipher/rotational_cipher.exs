defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(fn x ->
      rotate_char(x, shift)
    end)
    |> List.to_string()
  end

  defp rotate_char(char, shift) when char >= ?A and char <= ?Z do
    rotate_char_with_offset(char, shift, ?A)
  end

  defp rotate_char(char, shift) when char >= ?a and char <= ?z do
    rotate_char_with_offset(char, shift, ?a)
  end

  defp rotate_char(char, _shift) do
    char
  end

  defp rotate_char_with_offset(char, shift, offset) do
    rem(char + shift - offset, 26) + offset
  end
end
