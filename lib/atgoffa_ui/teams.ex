defmodule AtgoffaUi.Teams do
  import Ecto.Query, warn: false
  alias AtgoffaUi.Repo
  alias AtgoffaUi.Teams.Team
  require Logger

  def list_teams do
    Repo.all(Team)
  end

  def get_team!(id), do: Repo.get!(Team, id)

  def insert_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def create_teams(conn, %{site_id: site_id}) do
    api_token = Application.get_env(:atgoffa_ui, :api_token)
    Logger.info("API Token: #{api_token}")

    case call_teams_api(%{api_token: api_token, site_id: site_id}) do
      {:ok, data} ->
        process_and_insert(data)
        {:ok, "Teams created successfully"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def call_teams_api(%{api_token: api_token, site_id: site_id}) do
    {:ok, conn} = Mint.HTTP.connect(:https, "play-cricket.com", 443)

    {:ok, conn, request_ref} =
      Mint.HTTP.request(
        conn,
        "GET",
        "/api/v2/sites/#{site_id}/teams.json?api_token=#{api_token}",
        [],
        ""
      )

    receive_response(conn, request_ref, [])
  end

  defp receive_response(conn, request_ref, acc) do
    receive do
      message ->
        case Mint.HTTP.stream(conn, message) do
          {:ok, conn, responses} ->
            new_acc = handle_responses(responses, acc)

            if Enum.any?(responses, fn
                 {:done, _} -> true
                 _ -> false
               end) do
              {:ok, Enum.join(new_acc)}
            else
              receive_response(conn, request_ref, new_acc)
            end

          {:error, _conn, reason} ->
            {:error, reason}
        end
    end
  end

  defp handle_responses(responses, acc) do
    Enum.reduce(responses, acc, fn
      {:data, _request_ref, data}, acc -> acc ++ [data]
      _other, acc -> acc
    end)
  end

  @spec process_and_insert(
          binary()
          | maybe_improper_list(
              binary() | maybe_improper_list(any(), binary() | []) | byte(),
              binary() | []
            )
        ) :: :ok | {:error, :invalid_data}
  def process_and_insert(data) do
    case Poison.decode!(data) do
      %{"teams" => teams} when is_list(teams) ->
        Enum.each(teams, fn team_attrs ->
          %Team{team_id: team_attrs["id"]}
          |> Team.changeset(team_attrs)
          |> Repo.insert!()
        end)

      {:error, reason} ->
        Logger.error("Failed to decode JSON: #{inspect(reason)}")
        {:error, :invalid_data}
    end
  end
end
