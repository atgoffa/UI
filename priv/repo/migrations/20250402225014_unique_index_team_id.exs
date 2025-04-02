defmodule AtgoffaUi.Repo.Migrations.UniqueIndexTeamId do
  use Ecto.Migration

  def change do
    execute("DROP INDEX IF EXISTS teams_team_name_index")
    create unique_index(:teams, [:team_id])
  end
end
