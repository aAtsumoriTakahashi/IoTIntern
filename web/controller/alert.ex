defmodule IotIntern.Controller.Alert do
  use Antikythera.Controller

  alias Antikythera.Conn
  # 必要に応じて適宜エイリアスのコメントアウトを解除してください
  # alias IotIntern.Error
  # alias IotIntern.Linkit

  def post_alert(%{request: %{body: body}} = conn) do
    {:ok, datetime} = DateTime.now("Etc/UTC")
    datetime_iso8601 = DateTime.truncate(datetime, :second)
    case body do
      %{ "type" => type } when type in ["jamming", "derailment", "dead_battery"] -> Conn.json(conn, 200, %{sent_at: datetime_iso8601})
      _                                                                          -> Conn.json(conn, 400, %{"message" => "Unable to understand the request", "type" => "BadRequest"})
    end


  end
end
