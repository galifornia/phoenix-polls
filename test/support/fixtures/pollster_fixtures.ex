defmodule PhoenixPolls.PollsterFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixPolls.Pollster` context.
  """

  @doc """
  Generate a polls.
  """
  def polls_fixture(attrs \\ %{}) do
    {:ok, polls} =
      attrs
      |> Enum.into(%{
        choices: [],
        description: "some description",
        invited: [],
        is_public: true,
        title: "some title",
        type: "some type"
      })
      |> PhoenixPolls.Pollster.create_polls()

    polls
  end
end
