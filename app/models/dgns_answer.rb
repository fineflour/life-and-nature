class DgnsAnswer < ApplicationRecord

  has_many :diagno_questions, through: :diagno_question_answers
  has_many :diagno_question_answers

  validates :answer,   presence: true


  def self.getAnswer(id)
    DgnsAnswer.select(:name).where(id: id)
  end

  def self.getAnswer
    DgnsAnswer.select(:name, :id)
  end


end
