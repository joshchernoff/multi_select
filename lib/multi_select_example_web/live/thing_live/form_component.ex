defmodule MultiSelectExampleWeb.ThingLive.FormComponent do
  use MultiSelectExampleWeb, :live_component

  alias MultiSelectExample.Things

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage thing records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="thing-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Thing</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{thing: thing} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Things.change_thing(thing))
     end)}
  end

  @impl true
  def handle_event("validate", %{"thing" => thing_params}, socket) do
    changeset = Things.change_thing(socket.assigns.thing, thing_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"thing" => thing_params}, socket) do
    save_thing(socket, socket.assigns.action, thing_params)
  end

  defp save_thing(socket, :edit, thing_params) do
    case Things.update_thing(socket.assigns.thing, thing_params) do
      {:ok, thing} ->
        notify_parent({:saved, thing})

        {:noreply,
         socket
         |> put_flash(:info, "Thing updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_thing(socket, :new, thing_params) do
    case Things.create_thing(thing_params) do
      {:ok, thing} ->
        notify_parent({:saved, thing})

        {:noreply,
         socket
         |> put_flash(:info, "Thing created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
