defmodule VideoChat do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, VideoChat.Router, [], [port: 4001]),
      supervisor(VideoChat.Stack, [[:video_chat], [name: VideoChatServer]])
      # Starts a worker by calling: VideoChat.Worker.start_link(arg1, arg2, arg3)
      # worker(VideoChat.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VideoChat.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
