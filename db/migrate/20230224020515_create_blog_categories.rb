class CreateBlogCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_categories do |t|
      t.integer :category_id,         index: true, foreign_key: true       
      t.integer :pt_resource_id,      index: true, foreign_key: true       
      t.timestamps
    end
  end
end
