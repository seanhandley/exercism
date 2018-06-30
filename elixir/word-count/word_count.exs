defmodule Words do
  @forbidden ~r/[^\-\w]+/u
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(&String.replace(&1, @forbidden, ""))
    |> Enum.reject(&(&1 == ""))
    |> Enum.group_by(& &1)
    |> Enum.reduce(%{}, fn {word, occ}, acc ->
      Map.put(acc, word, length(occ))
    end)
  end
end
