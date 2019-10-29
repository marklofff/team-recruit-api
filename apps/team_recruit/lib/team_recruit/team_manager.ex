defmodule TeamRecruit.TeamManager do
  @moduledoc """
  The TeamManager context.
  """

  import Ecto.Query, warn: false

  alias TeamRecruit.Repo
  alias TeamRecruit.TeamManager.{Team, Member, JoinRequest}

  @doc """
  Returns the list of teams.

  ## Examples

  iex> list_teams()
  [%Team{}, ...]

  """
  def list_teams do
    Team
    |> order_by(desc: :inserted_at)
    |> preload(members: :user)
    |> Repo.all()
  end

  def paginate_teams(params \\ %{}) do
    Team
    |> preload([:user, :members, :games])
    |> Repo.paginate(params)
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
    Team
    |> where([t], t.id == ^id)
    |> preload([t], [:user, [members: :user], :awards, :games])
    |> Repo.one!()
  end

  def get_team_by_tag!(tag) do
    Team
    |> where([t], t.tag == ^tag)
    |> preload([t], [:user, [members: :user], :awards, :games])
    |> Repo.one!()
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
    query =
      from t in Team,
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
    game_ids = Enum.map(attrs["games"], fn x -> x["id"] end)

    games =
      TeamRecruit.Games.Game
      |> where([p], p.id in ^game_ids)
      |> Repo.all()

    team =
      %Team{user_id: user_id}
      |> Team.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:games, games)
      |> Repo.insert!()

    query =
      from t in Team,
      where: t.id == ^team.id,
      preload: [:user, :members, :games, :awards]

    {:ok, Repo.one(query)}
  end

  def add_member(%JoinRequest{} = join_request) do
    if join_request.accepted do
      {:ok, join_request}
    else
      Repo.transaction(fn -> 
        {:ok, updated_join_request} = update_join_request(join_request, %{accepted: true})

        add_member(updated_join_request.team.id, updated_join_request.user.id)
      end)
    end
  end

  def add_member(team_id, user_id, attrs \\ %{}) do
    %Member{team_id: team_id, user_id: user_id}
    |> Member.changeset(attrs)
    |> Repo.insert()
  end

  def delete_member(team_id, user_id) do
    member =
      Member
      |> preload([m], [:user, :team])
      |> where([m], m.user_id == ^user_id)
      |> where([m], m.team_id == ^team_id)
      |> Repo.one

     Repo.delete(member)
  end

  def add_game(team_id, game_id, _attrs \\ %{}) do
    team =
      team_id
      |> get_team!()
      |> Repo.preload([:user, :games])

    game = TeamRecruit.Games.get_game!(game_id)

    team
    |> Team.changeset(%{})
    |> Ecto.Changeset.put_assoc(:games, [game | team.games])
    |> Repo.update!()

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

  def create_join_request(user_id, team_id) do
    join_request = 
      %JoinRequest{user_id: user_id, team_id: team_id}
      |> JoinRequest.changeset(%{})
      |> Repo.insert()

    case join_request do
      {:ok, %JoinRequest{} = join_request} ->
        {:ok, Repo.preload(join_request, [:user, :team])}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def list_join_requests(%{team_id: team_id}, params) do
    JoinRequest
    |> where([j], j.team_id == ^team_id)
    |> preload([:user, [team: :user]])
    |> Repo.paginate(params)
  end

  def list_join_requests(%{user_id: user_id}, params) do
    JoinRequest
    |> where([j], j.user_id == ^user_id)
    |> preload([j], [:user, [team: :user]])
    |> Repo.paginate(params)
  end

  @doc """
  Gets a JoinRequest by id

  ## Examples

  iex> get_join_request(1)
  {:ok, %JoinRequest{...}}

  iex> get_join_request(1)
  ** (Ecto.NoResultsError)
  """
  def get_join_request(request_id) do
    JoinRequest
    |> where([j], j.id == ^request_id)
    |> preload([j], [:user, [team: :user]])
    |> Repo.one!()
  end

  @doc """
  Accepts a JoinRequest by id

  ## Examples

  iex> get_join_request(1)
  {:ok, %JoinRequest{...}}

  iex> get_join_request(1)
  ** (Ecto.NoResultsError)
  """
  def update_join_request(%JoinRequest{} = join_request, attrs) do
    join_request
    |> JoinRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a JoinRequest.

  ## Examples

  iex> delete_join_request(request_id)
  {:ok, %JoinRequests{}}}

  iex> delete_join_request(request_id)
  ** {:error, %Ecto.Changeset{}}
  """
  def delete_join_request(%JoinRequest{} = join_request) do
    Repo.delete(join_request)
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
