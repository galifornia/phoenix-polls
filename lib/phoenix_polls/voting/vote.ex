defmodule PhoenixPolls.Voting.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :selection, {:array, :integer}
    field :poll_id, :id

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:selection])
    |> validate_required([:selection])
  end
end
