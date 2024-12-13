defmodule MultiSelectExample.ExamplesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MultiSelectExample.Examples` context.
  """

  @doc """
  Generate a example.
  """
  def example_fixture(attrs \\ %{}) do
    {:ok, example} =
      attrs
      |> Enum.into(%{

      })
      |> MultiSelectExample.Examples.create_example()

    example
  end
end
