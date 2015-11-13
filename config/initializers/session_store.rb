# Be sure to restart your server when you modify this file.

#Workspace::Application.config.session_store :cookie_store, key: '_workspace_session'
Workspace::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes
