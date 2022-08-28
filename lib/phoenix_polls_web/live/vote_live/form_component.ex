defmodule PhoenixPollsWeb.VoteLive.FormComponent do
  use PhoenixPollsWeb, :live_component

  alias PhoenixPolls.Voting

  @impl true
  def update(%{vote: vote} = assigns, socket) do
    changeset = Voting.change_vote(vote)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"vote" => vote_params}, socket) do
    changeset =
      socket.assigns.vote
      |> Voting.change_vote(vote_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"vote" => vote_params}, socket) do
    save_vote(socket, socket.assigns.action, vote_params)
  end

  defp save_vote(socket, :edit, vote_params) do
    case Voting.update_vote(socket.assigns.vote, vote_params) do
      {:ok, _vote} ->
        {:noreply,
         socket
         |> put_flash(:info, "Vote updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_vote(socket, :new, vote_params) do
    case Voting.create_vote(vote_params) do
      {:ok, _vote} ->
        {:noreply,
         socket
         |> put_flash(:info, "Vote created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
