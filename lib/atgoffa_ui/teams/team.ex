defmodule AtgoffaUi.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive [Poison.Encoder]

  schema "teams" do
    field :team_id, :integer
    field :status, :string
    field :last_updated, :utc_datetime
    field :team_name, :string
    field :other_team_name, :string
    field :nickname, :string
    field :team_captain, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(team, params \\ %{}) do
    team
    |> cast(params, [:team_id, :status, :team_name, :other_team_name, :nickname, :team_captain])
    |> validate_required([:team_id, :status, :team_name])
    |> validate_length(:team_name, max: 160)
    |> validate_length(:other_team_name, max: 160)
    |> validate_length(:nickname, max: 160)
    |> validate_length(:team_captain, max: 160)
  end
end
