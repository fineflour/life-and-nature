class CreateDgnsAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :dgns_answers do |t|
      t.string  :answer,                null: false, default: ""
      t.integer :a_type,                  null: false, default: 0
      t.string :a_value,                 null: false, default: ''
      t.integer :sex,                   null: false, default: 0
      t.boolean :active,                default: true 





      t.timestamps
    end
  end
end
