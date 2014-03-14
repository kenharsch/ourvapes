json.array!(@config_controllers) do |config_controller|
  json.extract! config_controller, :id, :show
  json.url config_controller_url(config_controller, format: :json)
end
