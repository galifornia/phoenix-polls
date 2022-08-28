defmodule PhoenixPollsWeb.PollsLive.FormComponent do
  use PhoenixPollsWeb, :live_component

  alias PhoenixPolls.Pollster

  @impl true
  def update(%{polls: polls} = assigns, socket) do
    changeset = Pollster.change_polls(polls)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"polls" => polls_params}, socket) do
    changeset =
      socket.assigns.polls
      |> Pollster.change_polls(polls_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"polls" => polls_params}, socket) do
    save_polls(socket, socket.assigns.action, polls_params)
  end

  defp save_polls(socket, :edit, polls_params) do
    case Pollster.update_polls(socket.assigns.polls, polls_params) do
      {:ok, _polls} ->
        {:noreply,
         socket
         |> put_flash(:info, "Polls updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_polls(socket, :new, polls_params) do
    case Pollster.create_polls(polls_params) do
      {:ok, _polls} ->
        {:noreply,
         socket
         |> put_flash(:info, "Polls created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
