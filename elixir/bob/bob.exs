defmodule Bob do
  @no_lower_case "(?=^([^a-z]+)$)"
  @contains_upper_case "(?=(.*\\p{Lu}.*))"
  @yelling "#{@no_lower_case}#{@contains_upper_case}"
  @ends_with_question "(?=(.*\\?)"
  def hey(input) do
    cond do
      Regex.match?(~r/^\s*$/u, input) ->
        "Fine. Be that way!"

      Regex.match?(~r/#{@yelling}#{@ends_with_question}$)/u, input) ->
        "Calm down, I know what I'm doing!"

      Regex.match?(~r/#{@yelling}/u, input) ->
        "Whoa, chill out!"

      Regex.match?(~r/\?$/u, input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end
end
