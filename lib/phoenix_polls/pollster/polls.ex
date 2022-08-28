defmodule PhoenixPolls.Pollster.Polls do
  use Ecto.Schema
  import Ecto.Changeset

  schema "polls" do
    field :choices, {:array, :string}
    field :description, :string
    field :invited, {:array, Ecto.UUID}
    field :is_public, :boolean, default: false
    field :title, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(polls, attrs) do
    polls
    |> cast(attrs, [:title, :description, :type, :choices, :invited, :is_public])
    |> validate_required([:title, :description, :type, :choices, :invited, :is_public])
  end
end
