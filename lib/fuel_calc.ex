defmodule FuelCalc do
  @moduledoc """
  Documentation for `FuelCalc`.
  """

  @spec find_fuel(any, any) :: {:error, <<_::304>> | list} | {:ok, number}
  def find_fuel(mass, coordinates) when is_list(coordinates) do
   counted_values = Enum.map(coordinates, fn coordinate -> find_function_and_calculate(coordinate, mass) end)
   counted_values
   |> Enum.any?(fn {status, _} -> status == :error end)
   |> case do
   true ->
    counted_values
    |> Enum.filter(fn {status, _value} -> status == :error end)
    |> Enum.map(fn {_, message} -> message end)
    |> print_errors()
    false ->
      counted_values
      |> Enum.map(fn {_, value} -> value end)
      |> print_fuel_used()
    end
  end

  def find_fuel(_mass, _coordinates)  do
    IO.puts("incorrect list was given as parameters")
    {:error, "incorrect list was given as parameters"}
  end


  defp find_function_and_calculate({operation, gravity}, mass) when operation in [:land, :launch] do
    apply(LaunchLandCalculator, operation, [mass, gravity])
  end

  defp find_function_and_calculate({_operation, _gravity}, _mass)  do
    {:error, "operation used is not launch of land operation"}
  end

  defp find_function_and_calculate(_, _) do
    {:error, "coordinate is not a tuple"}
  end

  defp print_errors(error_list) do
    Enum.each(error_list, fn x -> IO.puts(x) end)
    {:error, error_list}
  end

  defp print_fuel_used(list) do
    IO.puts("fuels used for each operation is respectively:")
    Enum.each(list, fn x -> IO.puts(x) end)
    IO.puts("sum for fuels used is #{Enum.sum(list)}")
    {:ok, Enum.sum(list)}
  end
end
