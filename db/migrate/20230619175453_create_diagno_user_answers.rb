class CreateDiagnoUserAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :diagno_user_answers do |t|
      t.integer :user_id,             index: true, foreign_key: true
      t.integer :diagno_question_id,  index: true, foreign_key: true       
      t.integer :diagno_answer_id,    null: false, index: true, foreign_key: true       
      t.string  :value,               null: true, default: ""      

      t.timestamps
    end
  end
end
