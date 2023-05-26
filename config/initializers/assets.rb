# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")
Rails.application.config.assets.precompile += %w(application.js)
Rails.application.config.assets.precompile += %w(application.css)

 
  Rails.application.config.assets.precompile += %w(*.pdf, *.png *.jpg *.jpeg *.gif .svg .eot .woff .woff2 .ttf .css .wo .svg .eot .js)
  Rails.application.config.assets.precompile += %w(jquery.min.js jquery_ujs.js bootstrap.min.js popper.js)
    #config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.pdf)
  Rails.application.config.autoload_paths += %W(#{Rails.root}/app/assest/fonts)  
  Rails.application.config.autoload_paths += %W(#{Rails.root}/app/assest/fonts/jost)  
  Rails.application.config.autoload_paths += %W(#{Rails.root}/app/assest/stylesheets)  
  Rails.application.config.autoload_paths += %W(#{Rails.root}/app/assets/images)  
  Rails.application.config.autoload_paths += %W(#{Rails.root}/app/assets/resources)
#  Rails.application.config.autoload_paths += %W(#{Rails.root}/app/javascript)    
  Rails.application.config.autoload_paths += %W(#{Rails.root}/app/assets/javascripts)  
    



# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
