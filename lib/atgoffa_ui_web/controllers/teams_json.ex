defmodule AtgoffaUiWeb.TeamsJSON do
  alias AtgoffaUi.Teams.Team

  def index(%{teams: teams})  do
   %{data: for(team <- teams, do: data(team))}
  end



  defp data(%Team{} = team) do
    %{
     team_id: team.id,
     status: team.status,
     last_updated: team.last_updated,
     team_name: team.team_name,
     other_team_name: team.other_team_name,
     nickname: team.nickname,
     team_captain: team.team_captain
    }
  end
end
