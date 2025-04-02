defmodule AtgoffaUiWeb.TeamsController do
  use AtgoffaUiWeb, :controller

  alias AtgoffaUi.Teams
  alias AtgoffaUi.Teams.Team

  action_fallback AtgoffaUiWeb.FallbackController

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, :index, teams: teams)

    #json(conn, data)
  end

  def create_teams(conn, %{"site_id" => site_id}) do
    case Teams.create_teams(conn, %{site_id: site_id}) do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Teams created successfully"})

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end

  # def create(conn, %{"team" => team_params}) do
  #   with {:ok, %Team{} = team} <- Teams.insert_team(team_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.team_path(conn, :show, team))
  #     |> render("show.json", team: team)
  #   end
  end
