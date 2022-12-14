class PtResourcesController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper

  def index
    menu_values
    if (params[:key])
      security_key(params[:key])
      @pt_resource =  pt_resource_for_index  
    end if

    if(session[:admin])
      @pt_resource =  pt_resource_for_index  
    else
      @pt_resource = PtResource.article_by_menu_id(params[:menu_values])
    end
  end


  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @pt_resource= PtResource.find(params[:id])
    end
  end

  def new
    menu_values
    @pt_resource = PtResource.new
  end

  def create
    menu_values
    #binding.pry
    @pt_resource = PtResource.new(pt_resource_params)
    if @pt_resource.save
      flash[:notice] = "Article has been created successfully!"
      redirect_to pt_resources_path
    else
      flash[:error] = "patient resourc could not be saved."
      render action: :new
    end
  end

  def edit
    menu_values
    @pt_resource= PtResource.find(params[:id])
  end

  def update
    menu_values
    #binding.pry
    @pt_resource= PtResource.find(params[:id])
    @pt_resource.update(pt_resource_params)

    if  @pt_resource.save
      redirect_to  pt_resources_path, notice: "Successfully updated"
    else
      flash[:error] = "Patient resource cannot be updated. Try again"
      render :edit
    end
  end

  def destroy
    menu_values
    @pt_resource = PtResource.find(params[:id])
    if @pt_resource.destroy
      flash[:notice] = "The data successfully deleted"
      #redirect_to pt_resources_path, notice: "The data has been destroyed."
      redirect_to("/pt_resources")
    else 
      flash[:error] = "The data could not be destroyed."
      render :index
    end
  end



  private 

  def dismiss_admin
    session[:admin] = false;
   # binding.pry
    redirect_to pt_resources_path
  end

  def pt_resource_for_index
    if @admin
      PtResource.order("created_at DESC").
        #includes(:products, :orderproducts, :orderproduct_transitions).
        # text_search(params[:query]).
        paginate(page: params[:page])
    else

      PtResource.order("created_at DESC").
        where(active: true).
        #includes(:products, :orderproducts, :orderproduct_transitions).
        # text_search(params[:query]).
        paginate(page: params[:page])

    end
  end

  def pt_resource_params
    params.require(:pt_resource)
      .permit(:category, :menu_id, :title, :body, :link, :attached, :link, :active)
  end

  def menu_values
    menu_values ||= YAML.load((File.open("#{Rails.root}/config/menues.yml", 'r')))
    id = 400

    for n in menu_values
      if (n["id"] == id)
        @menu_values = n
      end
    end
  end

  def security_key(key)
    if key == 'dr.life-and-nature'
        #Rails.application.credentials.admin_key
      @admin = true
      session[:admin] =  true
    end
  end

  def get_pdf(file)
    if (file)
      @pdf_attachment = asset_path(file)
    end
  end
end
