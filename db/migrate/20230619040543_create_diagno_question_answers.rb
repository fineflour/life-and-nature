class CreateDiagnoQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :diagno_question_answers do |t|
      t.integer :diagno_question_id,  index: true, foreign_key: true       
      t.integer :dgns_answer_id,    null: false, index: true, foreign_key: true       


      t.timestamps
    end
  end
end
