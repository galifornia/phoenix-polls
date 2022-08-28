defmodule PhoenixPollsWeb.VoteLive.Index do
  use PhoenixPollsWeb, :live_view

  alias PhoenixPolls.Voting
  alias PhoenixPolls.Voting.Vote

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :votes, list_votes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Vote")
    |> assign(:vote, Voting.get_vote!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Vote")
    |> assign(:vote, %Vote{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Votes")
    |> assign(:vote, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    vote = Voting.get_vote!(id)
    {:ok, _} = Voting.delete_vote(vote)

    {:noreply, assign(socket, :votes, list_votes())}
  end

  defp list_votes do
    Voting.list_votes()
  end
end
