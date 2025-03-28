defmodule AtgoffaUi.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "players" do
    field :name, :string
    field :bat_type, :string
    field :bowl_type, :string
    field :is_allrounder, :boolean
    field :is_wicketkeeper, :boolean
    field :age, :integer

    has_many :teams, AtgoffaUi.Teams.Team, foreign_key: :team_id, references: :id

    timestamps(type: :utc_datetime)
  end

  def changeset(player, params \\ %{}) do
    player
    |> cast(params, [:name, :bat_type, :bowl_type, :is_allrounder, :is_wicketkeeper, :age])
    |> validate_required([:name, :bat_type, :bowl_type])
    |> validate_length(:name, max: 160)
    |> validate_length(:bat_type, max: 160)
    |> validate_length(:bowl_type, max: 160)
  end
end
