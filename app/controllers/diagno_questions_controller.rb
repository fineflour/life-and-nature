class DiagnoQuestionsController < ApplicationController
  require 'yaml'
  include ActionView::Helpers::AssetUrlHelper
  include Pundit::Authorization
  add_flash_types :info, :error, :success
  before_action :authenticate_user!
  def index
    menu_values
    if current_user.try(:admin?) || params[:menu_values] == '1002'
      @questions =  questions_for_index  
      @categories = category_list
    end
  end

  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @question = DiagnoQuestion.find(params[:id])
    end
  end

  def new
    menu_values
    @question = DiagnoQuestion.new
  end

  def create
    menu_values
    @question = DiagnoQuestion.new(question_params)
    @categories = category_list
    @answers = answer_list


    if @question.save
      flash[:notice] = "A question has been created successfully!"
      redirect_to diagno_questions_path
    else
      flash[:error] = "question could not be saved."
      render action: :new
    end
  end

  def edit
    menu_values
    @question = DiagnoQuestion.find(params[:id])
    @categories = category_list
    @answers = answer_list
  end

  def update
    menu_values
    #binding.pry
    @question = DiagnoQuestion.find(params[:id])
    @categories = category_list
    @answers = answer_list
    @question.update(question_params)

    if  @question.save
      redirect_to  diagno_questions_path, notice: "Successfully updated"
    else
      flash[:error] = "The question cannot be updated. Try again"
      render :edit
    end
  end

  def destroy
    menu_values
    @question = DiagnoQuestion.find(params[:id])
    if @question.destroy
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

  def questions_for_index
    if current_user.try(:admin?) 
        DiagnoQuestion.order("created_at DESC").
        includes(:categories, :diagno_category_questions).
        includes(:dgns_answers, :diagno_question_answers).
        paginate(page: params[:page])
    else

      DiagnoQuestion.order("created_at DESC").
        where(active: true).
        includes(:categories, :diagno_category_questions).
        paginate(page: params[:page])

    end
  end

  def question_params
    params.require(:diagno_question)
      .permit(:question, :q_type, :sex, :active, 
             :category_ids => [] 
             )
  end

  def category_list
    Category.select("name, id").order("name").where("active = true")
  end

  def answer_list
    DiagnoAnswer.select("answer, id").order("answer").where("active = true")
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
