defmodule ProbeApi.Positions do
  @moduledoc """
  The Positions context.
  """

  import Ecto.Query, warn: false
  alias ProbeApi.Repo

  alias ProbeApi.Positions.Position

  @doc """
  Returns all of the Probe's positions during it's way.

  ## Examples

      iex> list_positions()
      [%Position{}, ...]

  """
  def list_positions do
    Repo.all(Position)
  end

  @doc """
  Gets the Probe's current position.

  Raises `Ecto.NoResultsError` if there's no Position on the database.

  ## Examples

      iex> get_current_position!()
      %Position{}

      iex> get_current_position!()
      ** (Ecto.NoResultsError)

  """
  def get_current_position! do
    last(Position) |> Repo.one()
  end

  @doc """
  Puts the Probe on Mars at x = 0, y = 0, facing right.

  ## Examples

      iex> reset_probe()
      {:ok, %Position{x: 0, y: 0, face: "D"}}

  """
  def reset_probe do
    Position.changeset(%{x: 0, y: 0, face: "D"})
    |> Repo.insert()
  end

  @doc """
  Saves the Probe's new position.

  ## Examples

      iex> create_position(%{x: 0, y: 2, face: "C"})
      {:ok, %Position{}}

      iex> create_position(%{field: :bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_position(new_position) do
    Position.changeset(new_position)
    |> Repo.insert()
  end
end
