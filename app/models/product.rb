class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :product_categories
  scope :active, -> { where id: id}
  self.per_page = 20
  WillPaginate.per_page = 10


  CATEGORY_LIST = [['HERBS', 100], ['HOMEOPATHIC', 200],['NUTRITION', 300], ['DETOX', 400], ['3 PILLA', 500]]
  BRAND_LIST = [['Biotics Research', 100], ['Desbio', 200],['Han Jung', 300], ['Sun Ten', 400], ['Thorne', 500]]

  def self.getBrand(id)
    @data 
    @brands = BRAND_LIST

#    binding.pry
    for n in @brands
      if id == n[1].to_i
        @data = n[0]
        return @data
      else 
        @data = 'No Brand'
      end
    end
    @data
  end

end
