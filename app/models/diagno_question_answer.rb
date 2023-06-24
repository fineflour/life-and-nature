class DiagnoQuestionAnswer < ApplicationRecord
  belongs_to :diagno_question
  belongs_to :dgns_answer

  validates :diagno_question_id, :dgns_answer_id,   presence: true

end
