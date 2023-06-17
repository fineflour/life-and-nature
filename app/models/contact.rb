class Contact < ApplicationRecord
  has_one :subscription
  accepts_nested_attributes_for :subscription
   validates :name, :email, :phone, :message, :subject,  presence: true
   validates :email, format: { with:  /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/ , message: "address is not correct." }
#   validates :phone, format: { with: /\\([0-9]{3}\\)[0-9]{3}-[0-9]{4}/  , :message => "number format is not correct"}
  validates :phone, format: { with:  /\d[0-9]\)*\z/ , :message => "number format is not correct"}

                                           
end
