puts "seeding users..."
User.delete_all
User.create!(
  [
    { id: 1, fullname: "SooJin Mueller", email: "info@life-and-nature.com", role: 0, dob: "06/10/1979", phone: "714-443-1779", password: ENV["ADMIN_PASSWORD"], sex: 2 },
    { id: 2, fullname: "Dr Life", email: "dr.life@gmail.com", role: 1, dob: "09/07/1979", phone: "314-368-0966" , password: ENV["ADMIN_PASSWORD"]},
  ]
)

ActiveRecord::Base.connection.reset_pk_sequence!("users")
