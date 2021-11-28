defmodule ProbeApi.Positions.Position do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "positions" do
    field :face, :string
    field :x, :integer
    field :y, :integer

    timestamps()
  end

  @required [:x, :y, :face]
  @valid_faces ["D", "E", "C", "B"]

  @doc false
  def changeset(position \\ %__MODULE__{}, attrs) do
    position
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> validate_number(:x, greater_than_or_equal_to: 0, less_than_or_equal_to: 4)
    |> validate_number(:y, greater_than_or_equal_to: 0, less_than_or_equal_to: 4)
    |> validate_inclusion(:face, @valid_faces)
  end

  @doc """
  Returns a map of the positions's data without the Ecto metadata.
  """
  def to_map(%__MODULE__{} = position) do
    %{
      x: position.x,
      y: position.y,
      face: position.face
    }
  end
end
