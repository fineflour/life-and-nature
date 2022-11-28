class PtResourcesController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper
  def index

    if (params[:key])
      security_key(params[:key])
    end if

    menu_values
    @ptsrcs =  ptsrc_for_index  
  end


  def show
    menu_values
    @ptsrc = PtResource.find(params[:id])
  end

  def new
    menu_values
    @ptsrc = PtResource.new
  end

  def create
    menu_values
    @ptsrc = PtResource.new(ptsrc_params)
    if @ptsrc.save
      flash[:notice] = "ptsrc created successfully!"
      redirect_to ptsrcs_path
    else
      flash[:error] = "ptsrc could not be saved."
      render action: :new
    end
  end

  def edit
    menu_values
    @ptsrc = PtResource.find(params[:id])
  end

  def update
    menu_values
    @ptsrc = PtResource.find(params[:id])
    @ptsrc.update_attributes(ptsrc_params)

    if @ptsrc.save
      redirect_to @ptsrc, notice: "Successfully updated"
    else
      flash[:error] = "ptsrc cannot be updated. Try again"
      render :edit
    end
  end

  def destroy
    menu_values
    @ptsrc = PtResource.find(params[:id]).destroy
    flash[:notice] = "ptsrc successfully deleted"
    redirect_to ptsrcs_path
  end

  private 
  def ptsrc_for_index
    PtResource.order("created_at DESC").
      #includes(:products, :orderproducts, :orderproduct_transitions).
      # text_search(params[:query]).
      paginate(page: params[:page])
  end

  def ptsrc_params
    params.require(:ptsrc)
      .permit(:category, :title, :body, :link, :attached, :link, :active)
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
    if key =='lifeandnature'
      @admin = true
    end
  end

  def get_pdf(file)
    if (file)
      @pdf_attachment = asset_path(file)
    end
  end
end
