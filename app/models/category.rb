class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories
  scope :active, -> { where active: true }
  self.per_page = 20
  WillPaginate.per_page = 10

  TYPE_LIST = [['BLOGS', 100], ['PRODUCTS', 200]]

  def self.getCType(id)
    @data 
    @types = TYPE_LIST

    for n in @types
      if id == n[1]
        @data = n[0]
        return @data
      else 
        @data = 'No Type'
      end
    end
    @data
  end

  def self.getCategory(id)
    Category.select(:name).where(id: id)
  end

  def self.getCategories
    Category.select(:name, :id)
  end


end
