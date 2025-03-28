defmodule AtgoffaUi.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "matches" do
    field :league_name, :string
    field :pc_match_id, :integer
    field :away_team_name, :string
    field :home_team_name, :string
    field :competition_type, :string
    field :competition_name, :string
    field :season, :integer
    field :date, :utc_datetime
    field :location, :string
    field :result, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(match, params \\ %{}) do
    match
    |> cast(params, [:league_name, :away_team_name, :home_team_name, :competition_type, :competition_name, :season, :date, :location, :result])
    |> validate_required([:away_team_name, :home_team_name, :competition_type, :season, :date, :location])
    |> validate_length(:league_name, max: 160)
    |> validate_length(:away_team_name, max: 160)
    |> validate_length(:home_team_name, max: 160)
    |> validate_length(:competition_type, max: 160)
    |> validate_length(:competition_name, max: 160)
    |> validate_length(:location, max: 160)
  end

  # Define the changeset and repo functions here
end
