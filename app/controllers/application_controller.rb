class ApplicationController < ActionController::Base
  #before_action :add_www_subdomain
  include Pundit::Authorization
  def authenticate_user!
    @current_user = User.find_by_email params[:email]
    if !@current_user
      #@current_user = User.create :token => params[:auth_token]
    end
  end

  private
  def add_www_subdomain
    unless /^www/.match(request.host)
      redirect_to("#{request.protocol}www.#{request.host_with_port}",status: 301)
    end
  end

end
