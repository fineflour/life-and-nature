class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :product_categories
  scope :active, -> { where active: true}
  scope :by_category, -> (category) { joins(:product_categories).where('product_categories.category_id' => category) }
  scope :by_product, -> (product) { where("orderproducts.product_id = ?", product.id) }

  self.per_page = 20
  WillPaginate.per_page = 10


  CATEGORY_LIST = [['HERBS', 100], ['HOMEOPATHIC', 200],['NUTRITION', 300], ['DETOX', 400], ['3 PILLA', 500]]
  BRAND_LIST = [['Biotics Research', 100], ['Desbio', 200],['Han Jung', 300], ['Standard Process', 400], ['Sun Ten', 500], ['Thorne', 600]]

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

  def self.getProductList_by_category(id)
    query = self.product_categories(:category_id => id)
    query = query.where(active: true)
    query = query.order('id desc').limit(10)
    query
  end


end
