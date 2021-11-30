defmodule ProbeApi.Positions do
  @moduledoc """
  The Positions context.
  """

  import Ecto.Query, warn: false

  alias ProbeApi.Repo
  alias ProbeApi.Positions.Inputs.ListPositionsInput
  alias ProbeApi.Positions.Position

  @doc """
  Returns all of the Probe's final positions during it's way.

  ## Examples
  If the probe starter at x=0, y=0 facing right, and recieved a valid
  series of commands which led it to x=4, y=0 facing down.

      iex> list_positions()
      %{
        entries: [
          %Position{ x: 0, y: 0, face: "D"},
          %Position{ x: 4, y: 0, face: "B"}
        ],
        metadata: %{after: nil, before: nil}
      }

  """
  @spec list_positions(map()) :: Paginator.Page.t()
  def list_positions(input) do
    ListPositionsInput.paginate(input)
  end

  @doc """
  Gets the Probe's current position.
  Returns {:error, :no_probe} if no position is found on the database.

  ## Examples

      iex> get_current_position()
      %Position{}

      iex> get_current_position()
      {:error, :no_probe}

  """
  @spec get_current_position() :: Position.t() | nil
  def get_current_position do
    case last(Position) |> Repo.one() do
      nil -> {:error, :no_probe}
      position -> {:ok, position}
    end
  end

  @doc """
  Puts the Probe on Mars at x = 0, y = 0, facing right.

  ## Examples

      iex> reset_probe()
      {:ok, %Position{x: 0, y: 0, face: "D"}}

  """
  @spec reset_probe() :: {:ok, Position.t()}
  def reset_probe do
    Position.changeset(%{x: 0, y: 0, face: "D"})
    |> Repo.insert()
  end

  @doc """
  Saves the Probe's new position.

  ## Examples

      iex> create_position(%Position{x: 0, y: 2, face: "C"})
      {:ok, %Position{}}

      iex> create_position(%Position{field: :bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_position(map()) :: {:ok, Position.t()} | {:error, Ecto.Changeset.t()}
  def create_position(new_position) do
    new_position
    |> Position.changeset()
    |> Repo.insert()
  end
end
