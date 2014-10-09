
ActionController::Routing::Routes.draw do |map|
  map.connect '/auth/:provider/callback', :controller => 'account', :action => 'oauth_login'
end
