class DiagnoQuestion < ApplicationRecord

  has_many :diagno_question_answers 
  has_many :dgns_answers, through: :diagno_question_answers

  has_many :diagno_category_questions
  has_many :categories, through: :diagno_category_questions

  validates :question, :q_type,   presence: true

  scope :active, -> { where active: true}
  scope :is_selection_type, -> { where q_type: '3'}
  scope :by_category, -> (category) { joins(:diagno_category_questions).where('diagno_category_questions.category_id' => category) }

  CLASS_LIST = [['Digestive', 100], ['Nose', 200],['Emotion', 300], ['DETOX', 400], ['3 PILLA', 500]]
  TYPE_LIST = [['YES/NO', 1], ['NUMBER', 2],['SELECTION', 3], ['BLANK', 4]]
  SEX_LIST = [['All', 0], ['Male', 1], ['Female', 2],['Unknown', 3]]


  self.per_page = 20
  WillPaginate.per_page = 10

  def self.getQuestionType(id)
    @data 
    @qtype= TYPE_LIST

#    binding.pry
    for n in @qtype
      if id == n[1].to_i
        @data = n[0]
        return @data
      else 
        @data = 'No Type'
      end
    end
    @data
  end

  def self.getSex(id)
    @data 
    @sex = SEX_LIST

#    binding.pry
    for n in @sex
      if id == n[1].to_i
        @data = n[0]
        return @data
      else 
        @data = 'No Type'
      end
    end
    @data
  end
end
