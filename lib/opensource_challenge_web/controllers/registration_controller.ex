defmodule OpensourceChallengeWeb.RegistrationController do
  use OpensourceChallengeWeb, :controller

  alias OpensourceChallenge.Repo
  alias OpensourceChallenge.User

  def create(conn, %{
        "data" => %{
          "type" => "users",
          "attributes" => %{
            "name" => name,
            "email" => email,
            "password" => password,
            "password-confirmation" => password_confirmation
          }
        }
      }) do
    changeset =
      User.create_changeset(%User{}, %{
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      })

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(OpensourceChallengeWeb.UserView, "show.json-api", data: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(OpensourceChallengeWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
