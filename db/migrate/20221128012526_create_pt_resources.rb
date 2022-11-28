class CreatePtResources < ActiveRecord::Migration[7.0]
  def change
    create_table :pt_resources do |t|
      t.string :title
      t.text :body
      t.string :category
      t.string :link
      t.string :attached
      t.boolean :active
      t.boolean :public

      t.timestamps
    end
  end
end
