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
    if(params[:id].to_s == "dismiss_admin")
       dismiss_admin
    else 
      @qna_list = QuestionsAndAnswer.find(params[:id])
    end

   # authorize @qna_list
  end

  def new
    menu_values
    @qna_list = QuestionsAndAnswer.new
#    authorize @qna_list
  end

  def create
    menu_values
    @qna_list = QuestionsAndAnswer.new(qna_params)
#    authorize @qna_list
    if @qna_list.save
      flash[:notice] = "New Q & A created!"
      redirect_to questions_and_answers_path
    else
      flash[:error] = "New Q & A could not be created. Please check logs for more information."
      render action: :new
    end
  end

  def edit
    menu_values
    @qna_list = QuestionsAndAnswer.find(params[:id])
#    authorize @qna_list
  end

  def update
    menu_values
    @qna_list = QuestionsAndAnswer.find(params[:id])
    @qna_list.update(qna_params)

#    authorize @qna_list
    #@qna_list.update_attributes(user_is_global? ? global_params : user_params)

    if @qna_list.save
      redirect_to questions_and_answers_path, notice: "Successfully updated Q and A."
    else
      flash[:error] = "Q and A can not updated. Please try again."
      render :edit
    end
  end

  def destroy
    menu_values
    @qna_list= QuestionsAndAnswer.find(params[:id])
#    authorize @qna_list
    if @qna_list.destroy
      redirect_to questions_and_answers_path, notice: "Q and A has been destroyed."
    else
      flash[:error] = "Q and A could not be destroyed."
      render :index
    end
  end


  private
  def dismiss_admin
    #binding.pry
    current_user = nil;
    session[:admin] = nil;
    session[:user_id] = nil;
   # binding.pry
    redirect_to questions_and_answers_path
  end

  def questions_and_answers_for_index
    QuestionsAndAnswer.order("id").paginate(page: params[:page])
  end


  def qna_params

   #binding.pry
    #params.require(:diagno_question_and_answer).permit(:diagno_question_id, :dgns_answer_id)
    params.require(:questions_and_answer).permit(:qnestion, :answer, :view_count, :view)
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
