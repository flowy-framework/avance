defmodule Avance.Core.Notifiers.SlackNotifierTest do
  use ExUnit.Case

  import Mock

  @tag :slack_notifier
  test "notify/1" do
    reminder = %Avance.Schemas.Reminder{
      settings: %{"channel" => "#test"},
      description: "some description"
    }

    with_mock Avance.Support.SlackClient, post_message: fn "#test", "some description" -> :ok end do
      assert Avance.Core.Notifiers.SlackNotifier.notify(reminder) == :ok
    end
  end
end
