class CreateBlogCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_categories do |t|
      t.integer :category_id,              null: false, default: 0
      t.integer :blog_id,              null: false, default: 0
      t.timestamps
    end
  end
end
