class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name,              null: false, default: ""
      t.string :sku,              null: false, default: ""
      t.string :img_1,              null: false, default: ""
      t.string :img_2,              null: false, default: ""
      t.integer :sale,              null: false, default: 0
      t.decimal :price_1,              null: true, default: 0
      t.decimal :price_2,              null: true, default: 0
      t.integer:brand,              null: false, default: 0
      t.text :desc_1,              null: true, default: ""
      t.text :desc_2,              null: true, default: ""
      t.string :dosage,              null: true, default: ""
      t.text :usage,              null: true, default: ""
      t.text :ingredient,              null: true, default: ""
      t.boolean :active, default: true 

      t.timestamps null: false

    end
  end
end
