class CreateProductCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories do |t|

      t.integer :category_id, index: true, foreign_key: true
      t.integer :product_id,  index: true, foreign_key: true       
      t.timestamps
    end
  end
end
