class RegistrationsController< Devise::RegistrationsController
  def new
    @user = User.new
    authorize @user

  end

  def create
  end
end
