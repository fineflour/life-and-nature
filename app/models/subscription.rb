class Subscription < ApplicationRecord
  has_many:contacts
  scope :active, -> { where active: true }
  self.per_page = 20
  WillPaginate.per_page = 10

  validates :email, format: { with:  /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/ , message: "address is not correct." }
  validates :email, presence: true
end
