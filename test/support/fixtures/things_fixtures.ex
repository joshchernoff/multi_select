defmodule MultiSelectExample.ThingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MultiSelectExample.Things` context.
  """

  @doc """
  Generate a thing.
  """
  def thing_fixture(attrs \\ %{}) do
    {:ok, thing} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> MultiSelectExample.Things.create_thing()

    thing
  end
end
