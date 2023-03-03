class CategoriesController < ApplicationController
  require 'yaml'
  include ActionView::Helpers::AssetUrlHelper
  include Pundit::Authorization
  before_action :authenticate_user!

  def index
    menu_values
    if current_user.try(:admin?) || params[:menu_values] == '1002'
      @categories = category_for_index  
    end
  end

  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
      dismiss_admin
    else 
      @category = Category.find(params[:id])
    end
  end

  def new
    menu_values
    @category = Category.new
  end

  def create
    menu_values
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "A category has been created successfully!"
      redirect_to categories_path
    else
      flash[:error] = "category could not be saved."
      render action: :new
    end
  end

  def edit
    menu_values
    @category = Category.find(params[:id])
  end

  def update
    menu_values
    #binding.pry
    @category = Category.find(params[:id])
    @category.update(category_params)

    if  @category.save
      redirect_to  categories_path, notice: "Successfully updated"
    else
      flash[:error] = "Category cannot be updated. Try again"
      render :edit
    end
  end

  def destroy
    menu_values
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = "The data successfully deleted"
      #redirect_to pt_resources_path, notice: "The data has been destroyed."
      redirect_to("/categories")
    else 
      flash[:error] = "The data could not be destroyed."
      render :index
    end
  end

  def dismiss_admin
    session[:admin] = false;
    # binding.pry
    redirect_to categories_path
  end

  def category_for_index
    Category.order("created_at DESC").
      #includes(:products, :orderproducts, :orderproduct_transitions).
      # text_search(params[:query]).
      paginate(page: params[:page])

  end

  def category_params
    params.require(:category)
      .permit(:name, :c_type, :img_1, :img_2, :price_1,:price_2, :desc_1, :desc_2, :sale, :active, :package)
  end

  def menu_values
    menu_values ||= YAML.load((File.open("#{Rails.root}/config/menues.yml", 'r')))
    id = 1002

    for n in menu_values
      if (n["id"] == id)
        @menu_values = n
      end
    end
  end

end

