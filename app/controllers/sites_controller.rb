class SitesController < ApplicationController
 require 'yaml'
  def show
    #@first = params[:page]
    #@second= params[:page]
    menu_values
    reviews
    if params[:menu_values] ==  '500'
      @qna_list = to_qna_param
    end

    if params[:menu_values] ==  '704'
      galleries
    end



     render template: "sites/#{params[:site]}"
  end

  private
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


  def reviews
    reviews ||= YAML.load((File.open("#{Rails.root}/config/reviews.yml", 'r')))

    if(params[:menu_values])
      id = params[:menu_values].to_i
    else
      id = 100
    end


    for n in reviews 
      if (n["menu_id"] == id)
     #   binding.pry
        @reviews = n
      end
    end
  end

  def galleries

    @galleries ||= YAML.load((File.open("#{Rails.root}/config/galleries.yml", 'r')))

    #for n in galleries
    #  @galleries= n
     # binding.pry
    #end
  end




  def to_qna_param
    QuestionsAndAnswer.new 
    QuestionsAndAnswer.order("id")
    #QuestionsAndAnswer.order("id").paginate(page: params[:page])
  end
end
