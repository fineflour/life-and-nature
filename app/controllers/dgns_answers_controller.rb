class DgnsAnswersController < ApplicationController
  require 'yaml'
  include ActionView::Helpers::AssetUrlHelper
  include Pundit::Authorization
  add_flash_types :info, :error, :success
  before_action :authenticate_user!
  def index
    menu_values
    if current_user.try(:admin?) || params[:menu_values] == '1002'
#        binding.pry
      @answers =  answers_for_index  
      @question  = question_selection_type
    end
  end

  def show
    menu_values
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @answer = DgnsAnswer.find(params[:id])
    end
  end

  def new
    menu_values
    @answer = DgnsAnswer.new
  end

  def create
    menu_values
    @answer = DgnsAnswer.new(answer_params)
    @categories = category_list
    if @answer.save
      flash[:notice] = "A answer has been created successfully!"
      redirect_to diagno_answers_path
    else
      flash[:error] = "answer could not be saved."
      render action: :new
    end
  end

  def edit
    menu_values
    @answer = DgnsAnswer.find(params[:id])
    @categories = category_list
  end

  def update
    menu_values
    #binding.pry
    @answer = DgnsAnswer.find(params[:id])
    @categories = category_list
    @answer.update(answer_params)

    if  @answer.save
      redirect_to  dgns_answers_path, notice: "Successfully updated"
    else
      flash[:error] = "The answer cannot be updated. Try again"
      render :edit
    end
  end

  def destroy
    menu_values
    @answer = DgnsAnswer.find(params[:id])
    if @answer.destroy
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

  def answers_for_index
    if current_user.try(:admin?) 
        DgnsAnswer.order("created_at DESC").
#        includes(:diagno_questions, :diagno_question_answers).
        paginate(page: params[:page])
#        binding.pry
    else
    end
  end

  def answer_params
    params.require(:dgns_answer)
      .permit(:answer, :a_type, :a_value, :sex, :active, 
             :diagno_question_ids => [] 
             )
  end

  def question_selection_type
    DiagnoQuestion.select("question, id").order("name").where("active = true")
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
