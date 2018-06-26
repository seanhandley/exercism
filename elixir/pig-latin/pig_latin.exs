defmodule PigLatin do
  @vowels ~w(a e i o u yd yt xr xb)
  @specials ~w(qu squ)
  @consonants (?a..?z |> Enum.to_list() |> List.to_string() |> String.codepoints()) -- @vowels
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      String.starts_with?(word, @vowels) -> word <> "ay"
      String.starts_with?(word, @specials) -> switch_special(word) <> "ay"
      String.starts_with?(word, @consonants) -> switch_regular(word) <> "ay"
    end
  end

  defp switch_regular(word) do
    beginning =
      String.codepoints(word)
      |> Enum.take_while(fn x ->
        x in @consonants
      end)
      |> List.to_string()

    String.replace(word, beginning, "", global: false) <> beginning
  end

  defp switch_special(word) do
    beginning =
      Enum.find(@specials, fn special ->
        String.starts_with?(word, special)
      end)

    String.replace(word, beginning, "", global: false) <> beginning
  end
end
