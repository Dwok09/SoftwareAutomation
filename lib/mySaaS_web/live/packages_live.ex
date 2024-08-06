defmodule MySaaSWeb.PackagesLive do
  use MySaaSWeb, :live_view

  def mount(_params, _session, socket) do
    packages = Chocolatey.get_current_packages
    {:ok, assign(socket, packages: packages)}
  end

  def render(assigns) do
    ~H"""
    <div class="container">
      <h1>Installed Packages</h1>
      <%= if @packages == [] do %>
        <p>No packages available.</p>
      <% else %>
        <table class="table-auto w-full">
        <tr>
          <th class="w-1/4 px-4 py-2">Name</th>
          <th class="w-1/4 px-4 py-2">Version</th>
          <th class="w-1/4 px-4 py-2"></th>
          <th class="w-1/4 px-4 py-2"></th>
        </tr>
          <%= for package <- @packages do %>
            <tr>
              <td class="border px-4 py-2"><%= elem(package, 0) %><br></td>
              <td class="border px-4 py-2"><%= elem(package, 1) %><br></td>
              <td class="border px-4 py-2"><button type="button">Update</button></td>
              <td class="border px-4 py-2"><button type="button">Uninstall</button></td>
            </tr>
          <% end %>
        </table>
      <% end %>
    </div>
    """
  end

  def handle_event("refresh_packages", _params, socket) do
    packages = Chocolatey.get_current_packages()
    {:noreply, assign(socket, :packages, packages)}
  end
end