RailsAdmin.config do |config|
  config.authenticate_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      user = User.where(name: username).first
      user.authenticate(password) if user
    end
  end
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.navigation_static_links = {
    'Filtered blacklist' => '../admin/blacklist?model_name=blacklist&f[checked][19532][v]=false'
  }
end
