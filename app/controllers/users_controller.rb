class UsersController < ApplicationController
  require 'yaml'
  include Pundit::Authorization
  before_action :authenticate_user!

  def index
    menu_values
#    binding.pry
    @users = User.paginate(page: params[:page])
  end

  def show
    menu_values
    @user = User.find_by_id(params[:id])
  end

  def new
    menu_values
    @user = User.new
  end

  def create
    menu_values
    @user = User.new(new_user_params)
    #authorize @user
    if @user.save
      flash[:notice] = "New user created!"
      redirect_to users_path
    else
      flash[:error] = "New user could not be created. Please check logs for more information."
      render action: :new
    end
  end

  def edit
    menu_values
    @user = User.find(params[:id])
  end

  def update
    menu_values
    @user = User.find(params[:id])
    @user.update(user_params)

    if @user.save
      #redirect_to @user, notice: "Successfully updated user."
      redirect_to users_path

    else
      flash[:error] = "User not updated. Please try again."
      render :edit
    end
  end

  def destroy
    menu_values
  end

  private


  def user_params
    params.require(:user).permit(:email, :fullname, :role, :phone, :password, :dob)
  end


  def new_user_params
    params.require(:user).permit(:email, :fullname, :role, :phone, :password, :dob)
  end
end

def menu_values
  menu_values ||= YAML.load((File.open("#{Rails.root}/config/menues.yml", 'r')))
  id = 1000

  if(params[:menu_values])
    id = params[:menu_values].to_i
  else
    id = 1000
  end

  for n in menu_values
    if (n["id"] == id)
      @menu_values = n
    end
  end
end
