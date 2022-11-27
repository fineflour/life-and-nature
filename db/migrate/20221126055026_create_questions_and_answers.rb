class CreateQuestionsAndAnswers < ActiveRecord::Migration[7.0]
 def change
    create_table :questions_and_answers do |t|
    t.string :question,              null: false, default: ""
      t.text :answer,       null: false, default: ""
      t.integer :view_count,  default: 0, null: false
      t.boolean :show, default: true
      t.integer :view_order, default: 10000
      t.text :link, null: true


      t.timestamps
    end
  end
end
