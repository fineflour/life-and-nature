class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable,
    :recoverable, :rememberable, :validatable

  ROLES = [:admin, :user]
  SEX_LIST = [['Male', 1], ['Female', 2],['Unknown', 3]]

  enum role: ROLES
  after_initialize :set_default_role, :if => :new_record?

  self.per_page = 20
  WillPaginate.per_page = 10



  def admin?
    role == 'admin'
  end

  def set_default_role
    self.role ||= :user
  end
end
