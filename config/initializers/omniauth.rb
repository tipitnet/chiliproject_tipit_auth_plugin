ActionController::Dispatcher.middleware.use OmniAuth::Builder do #if you are using rails 2.3.x
#Rails.application.config.middleware.use OmniAuth::Builder do #comment out the above line and use this if you are using rails 3
  provider :developer unless Rails.env.production?
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end