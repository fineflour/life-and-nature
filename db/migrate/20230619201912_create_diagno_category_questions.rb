class CreateDiagnoCategoryQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :diagno_category_questions do |t|
      t.integer :category_id,         index: true, foreign_key: true       
      t.integer :diagno_question_id,  index: true, foreign_key: true       


      t.timestamps
    end
  end
end
