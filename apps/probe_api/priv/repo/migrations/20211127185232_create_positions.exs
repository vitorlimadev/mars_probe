defmodule ProbeApi.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions) do
      add :x, :integer
      add :y, :integer
      add :face, :string

      timestamps()
    end
  end
end
