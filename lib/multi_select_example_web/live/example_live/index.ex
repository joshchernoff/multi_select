defmodule MultiSelectExampleWeb.ExampleLive.Index do
  use MultiSelectExampleWeb, :live_view

  alias MultiSelectExample.Examples
  alias MultiSelectExample.Examples.Example

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :examples, Examples.list_examples())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Example")
    |> assign(:example, Examples.get_example!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Example")
    |> assign(:example, %Example{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Examples")
    |> assign(:example, nil)
  end

  @impl true
  def handle_info({MultiSelectExampleWeb.ExampleLive.FormComponent, {:saved, example}}, socket) do
    {:noreply, stream_insert(socket, :examples, example)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    example = Examples.get_example!(id)
    {:ok, _} = Examples.delete_example(example)

    {:noreply, stream_delete(socket, :examples, example)}
  end
end
