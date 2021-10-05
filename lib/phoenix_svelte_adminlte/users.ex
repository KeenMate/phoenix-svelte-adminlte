defmodule PhoenixSvelteAdminlte.Users do
  alias PhoenixSvelteAdminlte.Models.User

  def get_all_users() do
    [
      %User{user_id: 1, username: "dcooper", first_name: "Dale", last_name: "Cooper"},
      %User{user_id: 2, username: "htruman", first_name: "Harry", last_name: "Truman"},
      %User{user_id: 3, username: "sjohnson", first_name: "Shelly", last_name: "Johnson"},
      %User{user_id: 4, username: "bbriggs", first_name: "Bobby", last_name: "Briggs"},
      %User{user_id: 5, username: "bhorne", first_name: "Benjamin", last_name: "Horne"},
      %User{user_id: 6, username: "dhayward", first_name: "Donna", last_name: "Hayward"},
      %User{user_id: 7, username: "ahorne", first_name: "Audrey", last_name: "Horne"},
      %User{user_id: 8, username: "whayward", first_name: "Will", last_name: "Hayward"},
      %User{user_id: 9, username: "njennings", first_name: "Norma", last_name: "Jennings"},
      %User{user_id: 10, username: "jhurley", first_name: "James", last_name: "Hurley"},
      %User{user_id: 11, username: "ehurley", first_name: "Ed", last_name: "Hurley"},
      %User{user_id: 12, username: "pmartell", first_name: "Pete", last_name: "Martell"},
      %User{user_id: 13, username: "lpalmer", first_name: "Leland", last_name: "Palmer"},
      %User{user_id: 14, username: "jpackard", first_name: "Jocelyn", last_name: "Packard"},
      %User{user_id: 15, username: "cmartell", first_name: "Catherine", last_name: "Martell"},
      %User{user_id: 16, username: "lmoran", first_name: "Lucy", last_name: "Moran"}
    ]
  end

  def get_user(user_id) do
    get_all_users()
    |> Enum.find(fn x -> x.user_id == user_id end)
  end
end
