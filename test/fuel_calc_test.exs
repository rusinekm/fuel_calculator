defmodule FuelCalcTest do
  use ExUnit.Case
  doctest FuelCalc

  test "returns ok and value, when provided with correct data" do
    {status, _value} = FuelCalc.find_fuel(1, [{:launch, 3.0}])
    assert status == :ok
  end

  test "returns ok and value, when provided with correct data also as string" do
    {status, _value} = FuelCalc.find_fuel("1", [{:launch, "3.0"}])
    assert status == :ok
  end

  test "returns ok and value, when multiple tuples are given" do
    {status, _value} = FuelCalc.find_fuel("1", [{:launch, "3.0"}, {:launch, "3.0"}, {:launch, "3.0"}, {:launch, "3.0"}, {:launch, "3.0"}])
    assert status == :ok
  end

  test "returns error when data is not presented as tuples" do
    {status, message} = FuelCalc.find_fuel("1", [:launch, "3.0"])
    assert status == :error
    assert message == ["coordinate is not a tuple", "coordinate is not a tuple"]

  end

  test "returns error when incorrect data is presented" do
    {status, message} = FuelCalc.find_fuel("1", "some_data")
    assert status == :error
    assert message == "incorrect list was given as parameters"
  end

  test "returns error when other operations are to be used" do
    {status, message} = FuelCalc.find_fuel("1", [{:float, "3.0"}])
    assert status == :error
    assert message == ["operation used (float) is not one of available operations"]
  end
end
