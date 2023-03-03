class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name,              null: false, default: ""
      t.integer:c_type,              null: false, default: 0
      t.string :desc_1,              null: true, default: ""
      t.text :desc_2,              null: true, default: ""
      t.string :img_1,              null: false, default: ""
      t.string :img_2,              null: false, default: ""
      t.decimal :price_1,              null: true, default: 0
      t.decimal :price_2,              null: true, default: 0
      t.integer :sale,              null: true, default: 0
      t.boolean :active, default: true 
      t.boolean :package, default: false
      t.timestamps null: false
    end
  end
end
