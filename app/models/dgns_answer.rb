class DgnsAnswer < ApplicationRecord

  has_many :diagno_questions, through: :diagno_question_answers
  has_many :diagno_question_answers

  scope :is_active, -> { where active: true }
  validates :answer,   presence: true


  def self.getAnswer(id)
    DgnsAnswer.select(:answer).where(id: id)
  end

  def self.getAnswerList
    arr = []
    query = self.select(:answer, :id)
    for n in query 
      arr <<  [n["answer"], n["id"]] 
    end
    arr
  end

end
