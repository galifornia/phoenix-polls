defmodule PhoenixPolls.Pollster do
  @moduledoc """
  The Pollster context.
  """

  import Ecto.Query, warn: false
  alias PhoenixPolls.Repo

  alias PhoenixPolls.Pollster.Polls

  @doc """
  Returns the list of polls.

  ## Examples

      iex> list_polls()
      [%Polls{}, ...]

  """
  def list_polls do
    Repo.all(Polls)
  end

  @doc """
  Gets a single polls.

  Raises `Ecto.NoResultsError` if the Polls does not exist.

  ## Examples

      iex> get_polls!(123)
      %Polls{}

      iex> get_polls!(456)
      ** (Ecto.NoResultsError)

  """
  def get_polls!(id), do: Repo.get!(Polls, id)

  @doc """
  Creates a polls.

  ## Examples

      iex> create_polls(%{field: value})
      {:ok, %Polls{}}

      iex> create_polls(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_polls(attrs \\ %{}) do
    %Polls{}
    |> Polls.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a polls.

  ## Examples

      iex> update_polls(polls, %{field: new_value})
      {:ok, %Polls{}}

      iex> update_polls(polls, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_polls(%Polls{} = polls, attrs) do
    polls
    |> Polls.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a polls.

  ## Examples

      iex> delete_polls(polls)
      {:ok, %Polls{}}

      iex> delete_polls(polls)
      {:error, %Ecto.Changeset{}}

  """
  def delete_polls(%Polls{} = polls) do
    Repo.delete(polls)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking polls changes.

  ## Examples

      iex> change_polls(polls)
      %Ecto.Changeset{data: %Polls{}}

  """
  def change_polls(%Polls{} = polls, attrs \\ %{}) do
    Polls.changeset(polls, attrs)
  end
end
