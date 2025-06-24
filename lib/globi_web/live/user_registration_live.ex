

defmodule GlobiWeb.UserRegistrationLive do
  use GlobiWeb, :live_view

  alias Globi.Accounts
  alias Globi.Accounts.User

  def render(assigns) do
    ~H"""
    <h1>Registro de usuario</h1>
    <.form for={@form} phx-submit="save">
      <.input field={@form[:name]} type="text" label="Nombre" required />
      <.input field={@form[:last_name]} type="text" label="Apellido" required />
      <.input field={@form[:blood_type]} type="select" label="Tipo de sangre" required
        options={[
          {"O-", "O-"},
          {"O+", "O+"},
          {"A-", "A-"},
          {"A+", "A+"},
          {"B-", "B-"},
          {"B+", "B+"},
          {"AB-", "AB-"},
          {"AB+", "AB+"}
        ]}
      />
      <.input field={@form[:email]} type="email" label="Email" required />
      <.input field={@form[:password]} type="password" label="Contraseña" required />
      <button type="submit">Registrarse</button>
    </.form>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})
    form = to_form(changeset)
    {:ok, assign(socket, form: form)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Usuario registrado correctamente.")
         |> push_redirect(to: "/")}
      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
