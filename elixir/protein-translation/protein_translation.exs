defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    codons =
      Enum.chunk_every(String.codepoints(rna), 3)
      |> Enum.map(&List.to_string/1)
      |> Enum.map(&of_codon/1)

    cond do
      Enum.any?(codons, fn codon ->
        elem(codon, 0) == :error
      end) ->
        {:error, "invalid RNA"}

      true ->
        {:ok, codons |> Enum.map(&elem(&1, 1)) |> Enum.take_while(&(&1 != "STOP"))}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU => "Cysteine",
  UGC => "Cysteine",
  UUA => "Leucine",
  UUG => "Leucine",
  AUG => "Methionine",
  UUU => "Phenylalanine",
  UUC => "Phenylalanine",
  UCU => "Serine",
  UCC => "Serine",
  UCA => "Serine",
  UCG => "Serine",
  UGG => "Tryptophan",
  UAU => "Tyrosine",
  UAC => "Tyrosine",
  UAA => "STOP",
  UAG => "STOP",
  UGA => "STOP",
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    with {:ok, codon} <-
           Map.fetch(
             %{
               "UGU" => "Cysteine",
               "UGC" => "Cysteine",
               "UUA" => "Leucine",
               "UUG" => "Leucine",
               "AUG" => "Methionine",
               "UUU" => "Phenylalanine",
               "UUC" => "Phenylalanine",
               "UCU" => "Serine",
               "UCC" => "Serine",
               "UCA" => "Serine",
               "UCG" => "Serine",
               "UGG" => "Tryptophan",
               "UAU" => "Tyrosine",
               "UAC" => "Tyrosine",
               "UAA" => "STOP",
               "UAG" => "STOP",
               "UGA" => "STOP"
             },
             codon
           ) do
      {:ok, codon}
    else
      :error -> {:error, "invalid codon"}
    end
  end
end
