defmodule MultiSelectExample.Examples do
  @moduledoc """
  The Examples context.
  """

  import Ecto.Query, warn: false
  alias MultiSelectExample.Repo

  alias MultiSelectExample.Examples.Example

  @doc """
  Returns the list of examples.

  ## Examples

      iex> list_examples()
      [%Example{}, ...]

  """
  def list_examples do
    Repo.all(Example) |> Repo.preload([:thing])
  end

  @doc """
  Gets a single example.

  Raises `Ecto.NoResultsError` if the Example does not exist.

  ## Examples

      iex> get_example!(123)
      %Example{}

      iex> get_example!(456)
      ** (Ecto.NoResultsError)

  """
  def get_example!(id), do: Repo.get!(Example, id) |> Repo.preload([:thing])

  @doc """
  Creates a example.

  ## Examples

      iex> create_example(%{field: value})
      {:ok, %Example{}}

      iex> create_example(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_example(attrs \\ %{}) do
    %Example{}
    |> Example.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, example} -> {:ok, Repo.preload(example, [:thing]) |> dbg()}
      {:error, example} -> {:error, example}
    end
  end

  @doc """
  Updates a example.

  ## Examples

      iex> update_example(example, %{field: new_value})
      {:ok, %Example{}}

      iex> update_example(example, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_example(%Example{} = example, attrs) do
    example
    |> Example.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, example} -> {:ok, Repo.preload(example, [:thing]) |> dbg()}
      {:error, example} -> {:error, example}
    end
  end

  @doc """
  Deletes a example.

  ## Examples

      iex> delete_example(example)
      {:ok, %Example{}}

      iex> delete_example(example)
      {:error, %Ecto.Changeset{}}

  """
  def delete_example(%Example{} = example) do
    Repo.delete(example)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking example changes.

  ## Examples

      iex> change_example(example)
      %Ecto.Changeset{data: %Example{}}

  """
  def change_example(%Example{} = example, attrs \\ %{}) do
    Example.changeset(example, attrs)
  end
end
