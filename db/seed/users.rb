puts "seeding users..."
User.delete_all
User.create!(
  [
    { id: 1, fullname: "SooJin Mueller", email: "info@life-and-nature.com", password: ENV["DEFAULT_LAN_PASSWORD"], role: "Admin", dob: "06/10/1979", phone: "714-443-1779" },
    { id: 2, fullname: "Dr Life", email: "dr.life@gmail.com", password: ENV["DEFAULT_LAN_PASSWORD"], role: "member", dob: "09/07/1979", phone: "314-443-1779" },
  ]
)

ActiveRecord::Base.connection.reset_pk_sequence!("users")
