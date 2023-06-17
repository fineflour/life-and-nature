class SubscriptionsController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper
  def index
    if (params[:key]) 
      security_key(params[:key])
    end if
    menu_values
    @subscription_list = subscriptions_for_index    
  end

  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @subscription_list= Subscriptions.find(params[:id])
    end

   # authorize @qna_list
  end

  def new
    menu_values
    @subscription_list= Subscription.new
#    authorize @qna_list
  end

  def create
    menu_values
    @subscription_list= Subscription.new(subscription_params)
#    authorize @qna_list
    if @subscription_list.save
      flash[:notice] = "You're subscribed!"
      redirect_to request.referrer
    else
      flash[:error] = "We can not process your request now. Please try later"
      redirect_to request.referrer
    end
  end

  def edit
    menu_values
    @subscription_list= Subscriptions.find(params[:id])
#    authorize @qna_list
  end

  def update
    menu_values
    @subscription_list= subscriptions.find(params[:id])
    @subscription_list.update(subscription_params)

#    authorize @qna_list
    #@qna_list.update_attributes(user_is_global? ? global_params : user_params)

    if @subscription_list.save
      redirect_to subscriptions_path, notice: "Successfully updated Q and A."
    else
      flash[:error] = "Q and A can not updated. Please try again."
      render :edit
    end
  end

  def destroy
    menu_values
    @subscription_list= Subscriptions.find(params[:id])
#    authorize @qna_list
    if @subscription_list.destroy
      redirect_to subscriptions_path, notice: "Q and A has been destroyed."
    else
      flash[:error] = "Q and A could not be destroyed."
      render :index
    end
  end


  private
  def dismiss_admin
    session[:admin] = false;
   # binding.pry
    redirect_to subscriptions_path
  end

  def subscriptions_for_index
   subscriptions.order("id").paginate(page: params[:page])
  end


  def subscription_params

   #binding.pry
    params.require(:subscription).permit(:email, )
    #params.require(:qna).permit(:qnestion, :answer, :view_count, :view)
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
