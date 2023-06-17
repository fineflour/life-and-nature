class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :email,              null: false, default: ""
      t.boolean :active,            default: true 
      t.timestamps
    end
  end
end
