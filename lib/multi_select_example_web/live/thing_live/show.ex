defmodule MultiSelectExampleWeb.ThingLive.Show do
  use MultiSelectExampleWeb, :live_view

  alias MultiSelectExample.Things

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:thing, Things.get_thing!(id))}
  end

  defp page_title(:show), do: "Show Thing"
  defp page_title(:edit), do: "Edit Thing"
end
