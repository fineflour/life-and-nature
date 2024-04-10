class CreatePtResources < ActiveRecord::Migration[7.0]
  def change
    create_table :pt_resources do |t|
      t.string :title,       null: false, default: ""
      t.text :body,   null: false, default: ""
      t.string :category,  null: false, default: ""
      t.string :menu_id,  null: false, default: ""
      t.string :link,  null: true
      t.string :attached, null: true
      t.boolean :active, default: true 
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
