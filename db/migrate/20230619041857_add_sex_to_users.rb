class AddSexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sex, :integer
  end
end
