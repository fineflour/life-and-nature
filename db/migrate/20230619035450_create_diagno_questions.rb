class CreateDiagnoQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :diagno_questions do |t|
      t.string :question,               null: false, default: ""
      t.integer :q_type,                  null: false, default: 0
      t.integer :sex,                   null: false, default: 0
      t.boolean :active, default: true 

      t.timestamps
    end
  end
end
