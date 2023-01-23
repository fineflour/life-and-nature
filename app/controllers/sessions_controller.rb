class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
  #  binding.pry
    if !session[:return_to].blank?
      #redirect_to session[:return_to]
      redirect_to users_path
      #session[:return_to] = nil
    else
      redirect_to users_path
      #respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end
end
