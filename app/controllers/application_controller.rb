class ApplicationController < ActionController::Base
 #before_action :add_www_subdomain
end

private
def add_www_subdomain
  unless /^www/.match(request.host)
    redirect_to("#{request.protocol}www.#{request.host_with_port}",status: 301)
  end
end
