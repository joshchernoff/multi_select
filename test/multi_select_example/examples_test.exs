defmodule MultiSelectExample.ExamplesTest do
  use MultiSelectExample.DataCase

  alias MultiSelectExample.Examples

  describe "examples" do
    alias MultiSelectExample.Examples.Example

    import MultiSelectExample.ExamplesFixtures

    @invalid_attrs %{}

    test "list_examples/0 returns all examples" do
      example = example_fixture()
      assert Examples.list_examples() == [example]
    end

    test "get_example!/1 returns the example with given id" do
      example = example_fixture()
      assert Examples.get_example!(example.id) == example
    end

    test "create_example/1 with valid data creates a example" do
      valid_attrs = %{}

      assert {:ok, %Example{} = example} = Examples.create_example(valid_attrs)
    end

    test "create_example/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Examples.create_example(@invalid_attrs)
    end

    test "update_example/2 with valid data updates the example" do
      example = example_fixture()
      update_attrs = %{}

      assert {:ok, %Example{} = example} = Examples.update_example(example, update_attrs)
    end

    test "update_example/2 with invalid data returns error changeset" do
      example = example_fixture()
      assert {:error, %Ecto.Changeset{}} = Examples.update_example(example, @invalid_attrs)
      assert example == Examples.get_example!(example.id)
    end

    test "delete_example/1 deletes the example" do
      example = example_fixture()
      assert {:ok, %Example{}} = Examples.delete_example(example)
      assert_raise Ecto.NoResultsError, fn -> Examples.get_example!(example.id) end
    end

    test "change_example/1 returns a example changeset" do
      example = example_fixture()
      assert %Ecto.Changeset{} = Examples.change_example(example)
    end
  end
end
