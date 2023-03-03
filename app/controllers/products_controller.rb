class ProductsController < ApplicationController
  require 'yaml'
  include ActionView::Helpers::AssetUrlHelper
  include Pundit::Authorization
  before_action :authenticate_user!
  def index
    menu_values
    if current_user.try(:admin?) || params[:menu_values] == '1002'
      @products =  product_for_index  
      @categories = category_list
    end
  end

  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @product = Product.find(params[:id])
    end
  end

  def new
    menu_values
    @product = Product.new
  end

  def create
    menu_values
    @product = Product.new(product_params)
    @categories = category_list
    if @product.save
      flash[:notice] = "A product has been created successfully!"
      redirect_to products_path
    else
      flash[:error] = "product could not be saved."
      render action: :new
    end
  end

  def edit
    menu_values
    @product = Product.find(params[:id])
    @categories = category_list
  end

  def update
    menu_values
    #binding.pry
    @product = Product.find(params[:id])
    @categories = category_list
    @product.update(product_params)

    if  @product.save
      redirect_to  products_path, notice: "Successfully updated"
    else
      flash[:error] = "Product cannot be updated. Try again"
      render :edit
    end
  end

  def destroy
    menu_values
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "The data successfully deleted"
      #redirect_to pt_resources_path, notice: "The data has been destroyed."
      redirect_to("/products")
    else 
      flash[:error] = "The data could not be destroyed."
      render :index
    end
  end

  private

  def dismiss_admin
    session[:admin] = false;
   # binding.pry
    redirect_to products_path
  end

  def product_for_index
    if current_user.try(:admin?) 
        Product.order("created_at DESC").
        includes(:categories, :product_categories).
        paginate(page: params[:page])
    else

      Product.order("created_at DESC").
        where(active: true).
        includes(:categories, :product_categories).
        paginate(page: params[:page])

    end
  end

  def product_params
    params.require(:product)
      .permit(:name,:sku, :img_1, :img_2, :price_1,:price_2, :brand, :desc_1, :desc_2, :dosage, :usage,:ingredient, :sale, :active, 
             :category_ids => [] 
             )
  end

  def category_list
    Category.select("name, id").order("name").where("active = true")
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
