# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
Rails.application.config.action_dispatch.cookies_same_site_protection = :lax 
