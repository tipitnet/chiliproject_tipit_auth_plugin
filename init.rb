require 'redmine'

# Patches to the Redmine core.
require 'dispatcher'

Dispatcher.to_prepare :chiliproject_tipit_auth do

  require_dependency 'account_controller'
  unless AccountController.included_modules.include? TipitAuth::AccountControllerPatch
    AccountController.send(:include, TipitAuth::AccountControllerPatch)
  end
end

Redmine::Plugin.register :chiliproject_tipit_auth do
  name 'Chiliproject Tipit OAuth plugin'
  author 'NicoPaez'
  description 'This plugin implements OAuth supports for Chiliproject'
  version '0.0.1'
  url 'http://www.tipit.net/about'
end

ActionController::Dispatcher.middleware.use OmniAuth::Builder do #if you are using rails 2.3.x
#Rails.application.config.middleware.use OmniAuth::Builder do #comment out the above line and use this if you are using rails 3
  provider :developer unless Rails.env.production?
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end