class DiagnoUserAnswer < ApplicationRecord
  belongs_to :users
  belongs_to :diagno_questions
  belongs_to :diagno_question_ansers
end
