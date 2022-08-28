defmodule PhoenixPollsWeb.PollsLive.Index do
  use PhoenixPollsWeb, :live_view

  alias PhoenixPolls.Pollster
  alias PhoenixPolls.Pollster.Polls

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :polls_collection, list_polls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Polls")
    |> assign(:polls, Pollster.get_polls!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Polls")
    |> assign(:polls, %Polls{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Polls")
    |> assign(:polls, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    polls = Pollster.get_polls!(id)
    {:ok, _} = Pollster.delete_polls(polls)

    {:noreply, assign(socket, :polls_collection, list_polls())}
  end

  defp list_polls do
    Pollster.list_polls()
  end
end
