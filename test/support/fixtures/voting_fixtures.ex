defmodule PhoenixPolls.VotingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixPolls.Voting` context.
  """

  @doc """
  Generate a vote.
  """
  def vote_fixture(attrs \\ %{}) do
    {:ok, vote} =
      attrs
      |> Enum.into(%{
        selection: []
      })
      |> PhoenixPolls.Voting.create_vote()

    vote
  end
end
