class QuestionsAndAnswersController < ApplicationController
  include ActionView::Helpers::AssetUrlHelper

  def index
    if (params[:key])
      security_key(params[:key])
    end if

    menu_values
    @qna_list = questions_and_answers_for_index    
  end

  def show
    menu_values
    @qna= QuestionsAndAnswer.find(params[:id])
    authorize @qna
  end

  def new
    menu_values
    @qna= QuestionsAndAnswer.new
    authorize @qna
  end

  def create
    menu_values
    @qna= QuestionsAndAnswer.new(new_user_params)
    authorize @qna
    if @qna.save
      flash[:notice] = "New user created!"
      redirect_to users_path
    else
      flash[:error] = "New user could not be created. Please check logs for more information."
      render action: :new
    end
  end

  def edit
    menu_values
    @qna = QuestionsAndAnswer.find(params[:id])
    authorize @qna
  end

  def update
    menu_values
    @qna = QnestionsAndAnswer.find(params[:id])
    authorize @qna
    @qna.update_attributes(user_is_global? ? global_params : user_params)

    if @qna.save
      redirect_to @qna, notice: "Successfully updated Q and A."
    else
      flash[:error] = "Q and A not updated. Please try again."
      render :edit
    end
  end

  def destroy
    menu_values
    @qna= QuestionsAndAnswer.find(params[:id])
    authorize @qna
    if @qna.destroy
      redirect_to @qna, notice: "Q and A has been destroyed."
    else
      flash[:error] = "Q and A could not be destroyed."
      render :index
    end
  end


  private
  def questions_and_answers_for_index
    QuestionsAndAnswer.order("id").paginate(page: params[:page])
  end


  def qna_params
    params.require(:qna).permit(:qnestion, :answer, :view_count, :view)
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

end
