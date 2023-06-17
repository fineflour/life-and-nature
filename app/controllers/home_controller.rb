class HomeController < ApplicationController
def index
    @qna_list = to_qna_param
    menu_values
  end

  private
  def to_qna_param
    QuestionsAndAnswer.new 
    QuestionsAndAnswer.order("id")
    # QuestionsAndAnswer.order("id").paginate(page: params[:page])
  end


  def menu_values
    menu_values ||= YAML.load((File.open("#{Rails.root}/config/menues.yml", 'r')))

    if(params[:menu_values])
      id = params[:menu_values].to_i
    else
      id = 100
    end

    for n in menu_values
      if (n["id"] == id)
        @menu_values = n
      end
    end
  end
end
