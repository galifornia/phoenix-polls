defmodule PhoenixPolls.Repo.Migrations.CreatePolls do
  use Ecto.Migration

  def change do
    create table(:polls) do
      add :title, :string
      add :description, :string
      add :type, :string
      add :choices, {:array, :string}
      add :invited, {:array, :uuid}
      add :is_public, :boolean, default: false, null: false

      timestamps()
    end
  end
end
