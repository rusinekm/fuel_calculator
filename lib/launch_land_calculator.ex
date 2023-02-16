defmodule LaunchLandCalculator do
  @moduledoc false

  def launch(mass, gravity) when is_number(mass) and is_float(gravity) do
    with {:ok, _} <- check_gravity(gravity),
    {:ok, _} <- check_mass(mass),
    {:error, resp} <- find_fuel_to_launch(mass, gravity) do
       {:error, resp}
    else
      {:gravity, resp} -> {:error, resp}
      {:mass, resp} -> {:error, resp}
      value -> {:ok, value}
    end
  end


  def launch(mass, gravity) when is_number(mass) do
    case Float.parse(gravity) do
      {gravity_number, _} ->
          launch(mass, gravity_number)
      _ -> {:error, "mass is not a valid number"}
    end
  end

  def launch(mass, gravity) do
    case Float.parse(mass) do
      {mass_number, _} ->
      launch(mass_number, gravity)
      _ ->
        {:error, "gravity is not a valid number"}
    end
  end

  def land(mass, gravity) when is_number(mass) and is_float(gravity)do
    with {:ok, _} <- check_gravity(gravity),
    {:ok, _} <- check_mass(mass),
    {:error, resp} <- find_fuel_to_land(mass, gravity) do
      {:error, resp}
    else
      {:gravity, resp} -> {:error, resp}
      {:mass, resp} -> {:error, resp}
      value -> {:ok, value}
    end
  end


  def land(mass, gravity) when is_number(mass) do
    case Float.parse(gravity) do
      {gravity_number, _} ->
          land(mass, gravity_number)
      _ -> {:error, "gravity is not a valid number"}
    end
  end

  def land(mass, gravity) do
    case Float.parse(mass) do
      {mass_number, _} ->
          land(mass_number, gravity)
        _ -> {:error, "mass is not a valid number"}
    end
  end


  defp find_fuel_to_launch(mass, gravity) do
    fuel_used = Float.floor(mass * gravity * 0.042 - 33)
    case fuel_used  do
      i when i <= 0 ->
        0
      _ ->
        fuel_used + find_fuel_to_launch(fuel_used, gravity)
    end

  end


  defp find_fuel_to_land(mass, gravity) do
    fuel_used = Float.floor(mass * gravity * 0.033 - 42)
    case fuel_used  do
      i when i <= 0 ->
        0
      _ ->
        fuel_used + find_fuel_to_land(fuel_used, gravity)
    end

  end


  defp check_gravity(gravity) do
    if gravity < 0 do
      {:gravity, "gravity is negative number"}
    else
      {:ok, gravity}
    end
  end

  defp check_mass(mass) do
    if mass < 0 do
      {:mass, "mass is negative number"}
    else
      {:ok, mass}
    end
  end
end
