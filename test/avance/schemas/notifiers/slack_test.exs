defmodule Avance.Schemas.Notifiers.SlackTest do
  use ExUnit.Case

  @tag :schema_slack_notifier
  test "build/1" do
    settings = %{"channel" => "#test"}

    assert Avance.Schemas.Notifiers.Slack.build(settings) == %Avance.Schemas.Notifiers.Slack{
             channel: "#test"
           }

    settings = %{channel: "test"}

    assert Avance.Schemas.Notifiers.Slack.build(settings) == %Avance.Schemas.Notifiers.Slack{
             channel: "#test"
           }
  end
end
