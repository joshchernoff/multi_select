defmodule MultiSelectExampleWeb.HomeLive.Index do
  use MultiSelectExampleWeb, :live_view

  def render(assigns) do
    ~H"""
    <.simple_form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:email]} label="Email" />
      <.input field={@form[:username]} label="Username" />

      <:actions>
        <.button>Save</.button>
      </:actions>
    </.simple_form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
