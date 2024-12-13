defmodule MultiSelectExampleWeb.ExampleLive.FormComponent do
  use MultiSelectExampleWeb, :live_component

  alias MultiSelectExample.Examples

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage example records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="example-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <MultiSelectExampleWeb.SelectComponents.select
          field={@form[:thing_id]}
          id="select_component"
          label="Custom Select"
          options={
            MultiSelectExample.Things.list_things()
            |> Enum.map(fn thing -> {thing.title, thing.id} end)
          }
        />

        <:actions>
          <.button phx-disable-with="Saving...">Save Example</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{example: example} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Examples.change_example(example))
     end)}
  end

  @impl true
  def handle_event("validate", %{"example" => example_params}, socket) do
    changeset = Examples.change_example(socket.assigns.example, example_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"example" => example_params}, socket) do
    save_example(socket, socket.assigns.action, example_params)
  end

  defp save_example(socket, :edit, example_params) do
    case Examples.update_example(socket.assigns.example, example_params) do
      {:ok, example} ->
        notify_parent({:saved, example})

        {:noreply,
         socket
         |> put_flash(:info, "Example updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_example(socket, :new, example_params) do
    case Examples.create_example(example_params) do
      {:ok, example} ->
        notify_parent({:saved, example})

        {:noreply,
         socket
         |> put_flash(:info, "Example created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
