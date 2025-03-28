defmodule AtgoffaUi.Repo.Migrations.CreateMatchesTeamsPlayers do
  use Ecto.Migration

  def change do
    create table(:matches, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :pc_match_id, :integer
      add :league_name, :string
      add :away_team_name, :string
      add :home_team_name, :string
      add :competition_type, :string
      add :competition_name, :string
      add :season, :integer
      add :date, :utc_datetime
      add :location, :string
      add :result, :string
      timestamps(type: :utc_datetime)
    end

    create index(:matches, [:id])

    create table(:teams, primary_key: false) do

      add :id, :binary_id, primary_key: true
      add :team_id, :integer
      add :status, :string
      add :last_updated, :utc_datetime
      add :team_name, :string
      add :other_team_name, :string
      add :nickname, :string
      add :team_captain, :string
      timestamps(type: :utc_datetime)

    end
    create index(:teams, [:id])

    create table(:players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :bat_type, :string
      add :bowl_type, :string
      add :is_allrounder, :boolean
      add :is_wicketkeeper, :boolean
      add :age, :integer
      add :team_id, references(:teams, type: :binary_id)
      timestamps(type: :utc_datetime)
    end
    create index(:players, [:id])
  end
end
