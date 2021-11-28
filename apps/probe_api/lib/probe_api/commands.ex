defmodule ProbeApi.Commands do
  @moduledoc """
  See ProbeApi.Commands.run_commands/1
  """

  alias ProbeApi.Movement
  alias ProbeApi.Positions
  alias ProbeApi.Positions.Position
  alias ProbeApi.Rotation

  @valid_commands ["M", "GE", "GD"]

  @doc """
  Runs the movement commands and saves the new Probe position.
  Validates all of the commands and possible movement before execution.

  ## Examples

      iex> run_commands(["M", "M", "GE"])
      {:ok, %Position{}}

      iex> create_position(["M", "M", "GF"])
      {:error, :invalid_commands}

      iex> create_position(["M", "M", "M", "M", "M"])
      {:error, :impossible_movement}

  """
  @spec run_commands(list(binary())) ::
          {:ok, Position.t()} | {:error, :invalid_commands | :impossible_movement | :no_probe}
  def run_commands(commands) do
    commands
    |> validate_commands()
    |> execute_commands()
    |> update_position()
  end

  defp validate_commands(commands) do
    invalid_commands =
      commands
      |> Enum.filter(&(&1 not in @valid_commands))

    {commands, valid?: invalid_commands == []}
  end

  defp execute_commands({commands, valid?: true}) do
    with {:ok, current_position} <- Positions.get_current_position(),
         current_position <- Map.from_struct(current_position) do
      commands
      |> Enum.reduce_while(current_position, fn command, position ->
        case execute_command(position, command) do
          {:error, err} -> {:halt, {:error, err}}
          position -> {:cont, position}
        end
      end)
    else
      err -> err
    end
  end

  defp execute_commands({_commands, valid?: false}),
    do: {:error, :invalid_commands}

  defp execute_command(current_position, command) do
    case command do
      "M" ->
        Movement.move(current_position)

      "GE" ->
        Rotation.rotate(current_position, "GE")

      "GD" ->
        Rotation.rotate(current_position, "GD")
    end
    |> Position.changeset()
    |> case do
      %{valid?: true} = changeset ->
        changeset
        |> Ecto.Changeset.apply_action!(:update)
        |> Map.from_struct()

      _ ->
        {:error, :impossible_movement}
    end
  end

  defp update_position({:error, err}), do: {:error, err}

  defp update_position(new_position) do
    Positions.create_position(new_position)
  end
end
