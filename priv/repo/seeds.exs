# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Avance.Repo.insert!(%Avance.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Avance.Repo.delete_all(Avance.Schemas.Reminder)

project = Avance.Repo.insert!(%Avance.Schemas.Project{name: "Test"})

Avance.Repo.insert!(
  %Avance.Schemas.Reminder{
    project_id: project.id,
    reminder_type: :test,
    last_run_at: nil,
    timezone: "Europe/Madrid",
    description:
      ":star2: Hey Team! Just a Friendly Reminder! :star2: \n\n Don't forget to drop your updates here, keep it short and sweet! :rainbow: \n\n Appreciate your cooperation! :raised_hands:",
    settings: %{channel: "#avance-test"},
    schedule: "* */2 * * *",
    last_run_at: DateTime.truncate(DateTime.utc_now(), :second)
  },
  enabled: true
)
