defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) when nucleotide in @nucleotides do
    strand
    |> histogram
    |> Map.fetch!(nucleotide)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) when is_list(strand) do
    groups =
      strand
      |> Enum.filter(&(&1 in @nucleotides))
      |> Enum.group_by(& &1)

    for {k, v} <- groups,
        into: Map.new(@nucleotides, &{&1, 0}),
        do: {k, Enum.count(v)}
  end
end
