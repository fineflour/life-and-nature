require_relative "boot"
require "rails/all"
 
 

require 'simple_form'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LifeAndNature
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.autoload_paths += Dir["#{config.root}/lib/**/"]  
    config.active_record.legacy_connection_handling = false

    config.action_dispatch.cookies_same_site_protection = :strict
    # config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif .svg .eot .woff .woff2 .ttf .css .wo .svg .eot .js)

    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.pdf *.css *.js *woff *.woff2 *.svg)
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    # config.autoload_paths += %W(#{config.root}/app/builds/assest/fonts)  
    # config.autoload_paths += %W(#{config.root}/app/builds/assest/fonts/jost)  
    # config.autoload_paths += %W(#{config.root}/app/builds/assest/stylesheets) 
    # config.autoload_paths += %W(#{config.root}/app/builds/assets/images)  
    # config.autoload_paths += %W(#{config.root}/app/sbuilds/assets/resources)  
    # config.autoload_paths += %W(#{config.root}/app/sbuilds/assets/javascripts)  
    #
    config.autoload_paths += %W(#{config.root}/app/assest/fonts)  
    config.autoload_paths += %W(#{config.root}/app/assest/fonts/jost)  
    config.autoload_paths += %W(#{config.root}/app/assest/stylesheets) 
    config.autoload_paths += %W(#{config.root}/app/assest/stylesheets/jquery-ui) 
    config.autoload_paths += %W(#{config.root}/app/assets/images)  
    config.autoload_paths += %W(#{config.root}/app/assets/resources)  
    config.autoload_paths += %W(#{config.root}/app/assets/javascripts)  


    config.generators do |generate|
      generate.helper false
      generate.assets false
    end


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
