defmodule LaunchLandCalculator do
  @moduledoc false

  def launch(mass, gravity) do
    case find_fuel_to_launch(mass, gravity) do
      {:error, resp} -> {:error, resp}
      value -> {:ok, value}
    end
  end

  def land(mass, gravity) do
    case find_fuel_to_land(mass, gravity) do
      {:error, resp} -> {:error, resp}
      value -> {:ok, value}
  end

  end


  defp find_fuel_to_launch(mass, gravity) when is_number(mass) and is_float(gravity) do
    fuel_used = Float.floor(mass * gravity * 0.042 - 33)
    additional_fuel_used = case fuel_used  do
      i when i <= 0 -> 0
      _ -> find_fuel_to_launch(fuel_used, gravity)
    end
    fuel_used + additional_fuel_used
  end

  defp find_fuel_to_launch(mass, gravity) when is_number(mass) do
    case Float.parse(gravity) do
      {gravity_number, _} ->
        if gravity_number < 0 do
          {:error, "gravity is negative number"}
        else
          find_fuel_to_launch(mass, gravity_number)
        end
      _ -> {:error, "mass is not a valid number"}
    end
  end

  defp find_fuel_to_launch(mass, gravity) do
    case Float.parse(mass) do
      {mass_number, _} ->
        if mass_number < 0 do
          {:error, "mass is negative number"}
        else
          find_fuel_to_launch(mass_number, gravity)
        end
      _ ->
        {:error, "gravity is not a valid number"}
    end
  end

  defp find_fuel_to_land(mass, gravity) when is_number(mass) and is_float(gravity) do
    fuel_used = Float.floor(mass * gravity * 0.033 - 42)
    additional_fuel_used = case fuel_used  do
      i when i <= 0 -> 0
      _ -> find_fuel_to_land(fuel_used, gravity)
    end
    fuel_used + additional_fuel_used
  end

  defp find_fuel_to_land(mass, gravity) when is_number(mass) do
    case Float.parse(gravity) do
      {gravity_number, _} ->
        if gravity_number < 0 do
          {:error, "gravity is negative number"}
        else
          find_fuel_to_land(mass, gravity_number)
        end
      _ -> {:error, "gravity is not a valid number"}
    end
  end

  defp find_fuel_to_land(mass, gravity) do
    case Float.parse(mass) do
      {mass_number, _} ->
        if mass_number < 0 do
          {:error, "mass is negative number"}
        else
          find_fuel_to_land(mass_number, gravity)
        end
        _ -> {:error, "mass is not a valid number"}
    end
  end
end
