defmodule LaunchLandCalculatorTest do
  use ExUnit.Case
  doctest LaunchLandCalculator

  describe "launch" do
    test "finds correct value for launching when it should return 0" do
      assert LaunchLandCalculator.launch(2, 3.0) == {:ok, 0}
    end

    test "finds correct value for launching when it should return positive number" do
      assert LaunchLandCalculator.launch(200_000, 9.807) == {:ok, 139_553.0}
    end

    test "finds correct value for launching when presented with strings" do
      assert LaunchLandCalculator.launch("200000", "9.807") == {:ok, 139_553.0}
    end

    test "returns error when mass is negative" do
      assert LaunchLandCalculator.launch(-2, "3.0") == {:error, "mass is negative number"}
    end

    test "returns error when gravity is negative" do
      assert LaunchLandCalculator.launch(2, -3.0) == {:error, "gravity is negative number"}
    end
  end

  describe "land" do
    test "finds correct value for landing when it should return 0" do
      assert LaunchLandCalculator.land(2, 3.0) == {:ok, 0}
    end
    test "finds correct value for landing when it should return positive number" do
      assert LaunchLandCalculator.land(200_000, 9.807) == {:ok, 95_251.0}
    end

    test "finds correct value for land when presented with strings" do
      assert LaunchLandCalculator.land("200000", "9.807") == {:ok, 95_251.0}
    end

    test "returns error when mass is negative" do
      assert LaunchLandCalculator.land(-2, "3.0") == {:error, "mass is negative number"}
    end

    test "returns error when gravity is negative" do
      assert LaunchLandCalculator.land(2, -3.0) == {:error, "gravity is negative number"}
    end
  end

end
