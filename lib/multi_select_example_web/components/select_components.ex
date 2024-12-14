defmodule MultiSelectExampleWeb.SelectComponents do
  use Phoenix.Component
  alias MultiSelectExampleWeb.CoreComponents

  attr :id, :string, required: true
  attr :value, :any
  attr :name, :string
  attr :label, :string, default: nil
  attr :placeholder, :string, default: nil
  attr :options, :map, required: true
  attr :field, :map, required: true

  def select(assigns) do
    ~H"""
    <div>
      <label :if={@label} id={"#{@id}-label"} class="block text-sm/6 font-medium text-zinc-900">
        {@label}
      </label>
      <div class="relative mt-2">
        <button
          phx-click={CoreComponents.show("##{@id}_menu")}
          phx-click-away={CoreComponents.hide("##{@id}_menu")}
          type="button"
          class="min-h-9 grid w-full cursor-default grid-cols-1 rounded-md bg-white py-1.5 pl-3 pr-2 text-left text-zinc-900 outline outline-1 -outline-offset-1 outline-zinc-300 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
          aria-haspopup="listbox"
          aria-expanded="true"
          aria-labelledby={"#{@id}-label"}
        >
          <span :if={@field.value} class="col-start-1 row-start-1 truncate pr-6">
            {Enum.find(@options, fn {_k, v} -> v == @field.value end) |> Tuple.to_list() |> Enum.at(0)}
          </span>

          <span :if={!@field.value} class="col-start-1 row-start-1 truncate pr-6 text-zinc-500">
            {@placeholder}
          </span>

          <CoreComponents.icon
            name="hero-chevron-down"
            class="col-start-1 row-start-1 size-5 self-center justify-self-end text-zinc-500 sm:size-4"
          />
        </button>
        <ul
          id={"#{@id}_menu"}
          class="hidden absolute z-10 mt-2 max-h-32 w-full overflow-auto rounded-lg bg-white py-1 text-base shadow-2xl ring-1 ring-black/5 focus:outline-none sm:text-sm"
          role="listbox"
          aria-labelledby={"#{@id}-label"}
          tabindex="-1"
        >
          <li
            :for={{name, value} <- @options}
            tabindex="0"
            phx-keyup="select-item"
            phx-target={@myself}
            phx-value-id={@id}
            phx-value-selected={value}
            phx-click={
              Phoenix.LiveView.JS.set_attribute({"value", value}, to: "##{@id}-hidden")
              |> Phoenix.LiveView.JS.dispatch("hidden:dispatch", to: "##{@id}-hidden")
            }
            class={[
              "relative flex gap-x-2 items-center cursor-pointer select-none py-2 pl-3 hover:bg-gray-100 hover:text-indigo-600",
              @field.value == value &&
                "bg-gray-100 text-indigo-600 border border-l-4 border-t-0 border-b-0 border-r-0 border-indigo-600"
            ]}
            id={"#{@id}-option-#{value}"}
            role="option"
          >
            <span class={[
              "flex-1 truncate font-normal",
              @field.value == value && "font-semibold"
            ]}>
              {name}
            </span>

            <span :if={@field.value == value} class=" flex items-center pr-4 text-indigo-600">
              <CoreComponents.icon name="hero-check-circle" />
            </span>
          </li>
          <script>
            dispatchEvent(
              new Event("input", {bubbles: true})
            )
          </script>
        </ul>
        <CoreComponents.input type="hidden" field={@field} id={"#{@id}-hidden"} />
      </div>
    </div>
    """
  end
end
