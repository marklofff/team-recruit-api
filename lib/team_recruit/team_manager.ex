defmodule TeamRecruit.TeamManager do
  @moduledoc """
  The TeamManager context.
  """

  import Ecto.Query, warn: false
  alias TeamRecruit.Repo

  alias TeamRecruit.TeamManager.{Team, Member}

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    query = from u in Team,
      preload: [:user, :members, :awards, :games]
    Repo.all(query)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id) do 
    Repo.get!(Team, id)
    |> Repo.preload([:user, :members, :awards, :games])
  end

  def get_team_by_tag!(tag) do 
    query = from t in Team,
        where: t.tag == ^tag

    Repo.one!(query)
    |> Repo.preload([:user, :members, :awards, :games])
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_my_teams(user_id) do 
    query = from t in Team,
      where: t.user_id == ^user_id,
      preload: [:user, :members, :awards, :games]

    Repo.all(query)
  end

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(user_id, attrs \\ %{}) do
    game_ids = Enum.map(attrs["games"], fn(x) -> x["id"] end)

    games = TeamRecruit.Games.Game
            |> where([p], p.id in ^game_ids)
            |> Repo.all
    

    team = %Team{user_id: user_id}
            |> Team.changeset(attrs)
            |> Ecto.Changeset.put_assoc(:games, games) 
            |> Repo.insert!()

    query = from t in Team,
      where: t.id == ^team.id,
      preload: [:user, :members, :games, :awards]

    {:ok, Repo.one(query)}
  end

  def add_member(team_id, user_id, attrs \\ %{}) do
    {:ok, member} =
      %Member{team_id: team_id, user_id: user_id}
      |> Member.changeset(attrs)
      |> Repo.insert()

    query = from m in Member,
      where: m.id == ^member.id,
      preload: [:user, :team]

    {:ok, Repo.one(query)}
  end

  def add_game(user, team_id, game_id, attrs \\ %{}) do
    team = get_team!(team_id) |> Repo.preload([:user, :games])
    game = TeamRecruit.Games.get_game!(game_id)

    if is_team_leader?(user, team) do
      team
      |> Team.changeset(%{})
      |> Ecto.Changeset.put_assoc(:games, [game | team.games]) 
      |> Repo.update!()
    end

    {:ok, team}
  end

  def is_team_leader?(user, team) do
    team.user.id == user.id
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{source: %Team{}}

  """
  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end
end
