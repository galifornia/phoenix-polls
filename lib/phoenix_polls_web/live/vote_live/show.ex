defmodule PhoenixPollsWeb.VoteLive.Show do
  use PhoenixPollsWeb, :live_view

  alias PhoenixPolls.Voting

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:vote, Voting.get_vote!(id))}
  end

  defp page_title(:show), do: "Show Vote"
  defp page_title(:edit), do: "Edit Vote"
end
