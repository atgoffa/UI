defmodule AtgoffaUiWeb.FallbackController do
  use AtgoffaUiWeb, :controller

  # This is a fallback controller that handles errors and sends appropriate responses.
  # It uses the `Phoenix.Controller` module to render JSON responses for different error cases.

  # Handles errors when a resource is not found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    #|> put_view(AtgoffaUiWeb.ErrorView)
    |> render(:"404")
  end

  # Handles errors when there is an internal server error.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
   # |> put_view(AtgoffaUiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
