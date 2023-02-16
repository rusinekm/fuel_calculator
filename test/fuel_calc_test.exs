defmodule FuelCalcTest do
  use ExUnit.Case
  doctest FuelCalc

  test "greets the world" do
    assert FuelCalc.hello() == :world
  end
end
