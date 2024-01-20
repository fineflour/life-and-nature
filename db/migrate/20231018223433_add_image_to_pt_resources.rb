class AddImageToPtResources < ActiveRecord::Migration[7.0]
  def change
    add_column :pt_resources, :image, :string, default: 'none.png'
    add_column :pt_resources, :isnew, :boolean, default: false
    add_column :pt_resources, :view, :integer, default: 0
  end
end
