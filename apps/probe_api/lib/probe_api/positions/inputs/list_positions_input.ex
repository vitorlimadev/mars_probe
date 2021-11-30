defmodule ProbeApi.Positions.Inputs.ListPositionsInput do
  @moduledoc """
  Input for listing positions with pagination
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ProbeApi.Positions.Position
  alias ProbeApi.Repo

  @pagination_fields [
    :after,
    :before
  ]

  @primary_key false
  embedded_schema do
    field :after, :string
    field :before, :string
  end

  def changeset(module \\ %__MODULE__{}, params) do
    module
    |> cast(params, @pagination_fields)
  end

  def paginate(cursor) do
      Repo.paginate(Position,
        after: cursor["after"],
        before: cursor["before"],
        cursor_fields: [:inserted_at, :id],
        limit: 5
      )
  end
end
