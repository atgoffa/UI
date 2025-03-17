defmodule AtgoffaUi.Repo.Migrations.AddUserName do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string, null: true
    end
  end
end
