class ContactsController < ApplicationController
 include ActionView::Helpers::AssetUrlHelper

  def index
    if (params[:key]) 
      security_key(params[:key])
    end if

    menu_values
    @contact_list = contacts_for_index    
  end

  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @contact_list = Contact.find(params[:id])
    end

   # authorize @contact_list
  end

  def new
    menu_values
    @contact_list = Contact.new
  end

  def create
    menu_values
    @contact_list = Contact.new(contact_params)
#    authorize @contact_list
      flash[:error] = ""
    if @contact_list.save
      flash[:notice] = "We will reply to your email soon. Thank you!"
      redirect_to request.referrer
    else
      flash[:error] = "Sorry, An error has occurred. Please try again"
      render action: :new
    end
  end

  def edit
    menu_values
    @contact_list = Contact.find(params[:id])
#    authorize @contact_list
  end

  def update
    menu_values
    @contact_list = Contact.find(params[:id])
    @contact_list.update(contact_params)

#    authorize @contact_list
    #@contact_list.update_attributes(user_is_global? ? global_params : user_params)

    if @contact_list.save
      redirect_to contacts_path, notice: "Successfully updated your request."
    else
      flash[:error] = "Your request can not be done. Please try again."
      render :edit
    end
  end

  def destroy
    menu_values
    @contact_list= Contact.find(params[:id])
#    authorize @contact_list
    if @contact_list.destroy
      redirect_to contacts_path, notice: "Your request has been idone."
    else
      flash[:error] = "Your request can not be done."
      render :index
    end
  end


  private
  def dismiss_admin
    session[:admin] = false;
   # binding.pry
    redirect_to contacts_path
  end


  def contacts_for_index
    Contact.order("id").paginate(page: params[:page])
  end


  def contact_params
#   binding.pry
#    params.require(:contact).permit(:name, :email, :phone, :massage, :subscription_attributes => [params[:contact][:email], :active])
    params.require(:contact).permit(:name, :email, :phone, :subject,  :message )

  end


  def menu_values
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
  def security_key(key)
    if key == ENV["ADMIN_PASSWORD"]
        #Rails.application.credentials.admin_key
      @admin = true
      session[:admin] =  true
    end
  end
end
