class ApplicationController < ActionController::Base
  #before_action :add_www_subdomain
  before_action :get_menu_values
end

private
def add_www_subdomain
  unless /^www/.match(request.host)
    redirect_to("#{request.protocol}www.#{request.host_with_port}",status: 301)
  end
end

def get_menu_values
  menu_values ||= YAML.load((File.open("#{Rails.root}/config/menues.yml", 'r')))

  if(params[:menu_values])
    id = params[:menu_values].to_i
  else
    id = 500
  end

    for n in menu_values
      if (n["id"] == id)
        @menu_values = n
      end
    end
  end

