RailsAdmin.config do |config|
  require 'nested_form/engine'
  require 'nested_form/builder_mixin'

  config.authenticate_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == Rails.application.credentials.admin_username && password == Rails.application.credentials.admin_password
    end
  end

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
