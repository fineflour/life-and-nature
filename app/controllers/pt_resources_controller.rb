class PtResourcesController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper

  def index
    menu_values
      @pt_resource =  pt_resource_for_index  
      @recent_blog  = pt_resource_for_recent
  end

  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @pt_resource= PtResource.find(params[:id])
    end
  end

  def blog
      @pt_resource= PtResource.find(params[:id])
  end


  def new
    menu_values
    @pt_resource = PtResource.new
  end

  def create
    menu_values
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
    @pt_resource = PtResource.find(params[:id])
  end

  def update
    menu_values
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
    redirect_to pt_resources_path
  end

  def pt_resource_for_index
    if current_user[:role]=="admin"  
      if params[:query].present?
        PtResource.by_date.
          text_search(params[:query]).
          paginate(page: params[:page])

      elsif params[:category].present?
        PtResource.by_date.
          category(params[:category]).
          paginate(page: params[:page])
      else
        PtResource.by_date.
          paginate(page: params[:page])
      end

    else
      if params[:query].present?
        PtResource.order("created_at DESC").
          text_search(params[:query]).
          where(active: true).
          where(isnew: false).
          paginate(page: params[:page])

      elsif params[:category].present?
        PtResource.order("created_at DESC").
          where(active: true).
          where(isnew: false).
          category(params[:category]).
          paginate(page: params[:page])

      else
        PtResource.order("created_at DESC").
          where(active: true).
          where(isnew: false).
          paginate(page: params[:page])
      end
    end
  end

  def pt_resource_for_recent
    PtResource.by_date.
      # text_search(params[:query]).
      where(isnew: true).
      includes(:blog_categories)
  end

  def pt_resource_params
    params.require(:pt_resource)
      .permit(:category, :menu_id, :title, :body, :link, :attached, :link, :active, :public, :isnew, :image,
              :category_ids => [],
              :menu_ids => []
             )
  end

  def menu_values
    menu_values ||= YAML.load((File.open("#{Rails.root}/config/menues.yml", 'r')))

    if(params[:menu_values])
      id = params[:menu_values].to_i
    else
      id = 400
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

  def get_pdf(file)
    if (file)
      @pdf_attachment = asset_path(file)
    end
  end
end
