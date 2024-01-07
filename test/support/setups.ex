defmodule Avance.Test.Setups do
  @moduledoc false
  alias Avance.Tests.Fixtures.{
    ProjectFixtures,
    ReminderFixtures,
    EntryFixtures,
    DigestFixtures,
    DigestProjectFixtures,
    NewsieFixtures,
    AccountFixtures,
    UserFixtures
  }

  def setup_account(%{user: user} = context) do
    account = AccountFixtures.account_fixture(%{owner_id: user.id})

    context
    |> add_to_context(%{account: account})
  end

  def setup_account(context) do
    context
    |> setup_user()
    |> setup_account()
  end

  def setup_newsie(%{digest: %{id: digest_id}} = context) do
    newsie = NewsieFixtures.newsie_fixture(%{digest_id: digest_id})

    context
    |> add_to_context(%{newsie: newsie})
  end

  def setup_newsie(context) do
    context
    |> setup_digest()
    |> setup_newsie()
  end

  def setup_digest_project(%{project: %{id: project_id}, digest: %{id: digest_id}} = context) do
    digest_project =
      DigestProjectFixtures.digest_project_fixture(%{project_id: project_id, digest_id: digest_id})

    context
    |> add_to_context(%{digest_project: digest_project})
  end

  def setup_digest(context) do
    digest = DigestFixtures.digest_fixture()

    context
    |> add_to_context(%{digest: digest})
  end

  def setup_entry(%{project: project} = context) do
    %{id: project_id} = project

    entry =
      %{project_id: project_id}
      |> EntryFixtures.entry_fixture()

    context
    |> add_to_context(%{entry: entry})
  end

  def setup_entry(context) do
    context
    |> setup_project()
    |> setup_entry()
  end

  def setup_reminder(%{project: project} = context) do
    %{id: project_id} = project

    reminder =
      %{project_id: project_id}
      |> ReminderFixtures.reminder_fixture()

    context
    |> add_to_context(%{reminder: reminder})
    |> add_to_context(%{project: project})
  end

  def setup_reminder(context) do
    %{project: %{id: project_id} = project} = setup_project(context)

    reminder =
      %{project_id: project_id}
      |> ReminderFixtures.reminder_fixture()

    context
    |> add_to_context(%{reminder: reminder})
    |> add_to_context(%{project: project})
  end

  def setup_project(%{account: account} = context) do
    project = ProjectFixtures.project_fixture(%{account_id: account.id})

    context
    |> add_to_context(%{project: project})
  end

  def setup_project(context) do
    context
    |> setup_account()
    |> setup_project()
  end

  def setup_user(context) do
    user = UserFixtures.user_fixture()

    context
    |> add_to_context(%{user: user})
  end

  defp add_to_context(context, attrs) do
    context
    |> Enum.into(attrs)
  end
end
