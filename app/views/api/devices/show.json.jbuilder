<% title "Api/Device" %>

<p>
  <strong>Name:</strong>
  <%= @device.name %>
</p>

<p>
  <%= link_to "Edit", edit_api_device_path(@device) %> |
  <%= link_to "Destroy", [:api, @device], :confirm => 'Are you sure?', :method => :delete %> |
  <%= link_to "View All", api_devices_path %>
</p>
