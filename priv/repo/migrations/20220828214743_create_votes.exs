defmodule PhoenixPolls.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :selection, {:array, :integer}
      add :poll_id, references(:polls, on_delete: :nothing)

      timestamps()
    end

    create index(:votes, [:poll_id])
  end
end
