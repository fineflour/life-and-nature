class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name,              null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :phone,              null: false, default: ""
      t.string :subject,              null: false, default: ""
      t.text  :message,       null: false, default: ""

      t.timestamps
    end
  end
end
