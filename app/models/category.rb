class Category < ApplicationRecord
  has_many :products, through: :product_categories
  has_many :product_categories
  has_many :blogs, through: :blog_categories
  has_many :blog_categories

  has_many :diagno_category_questions
  has_many :diagno_questions, through: :diagno_category_questions

  scope :active, -> { where active: true }
  scope :is_blog, -> { where c_type: 100}
  scope :is_product, -> { where c_type: 200}
  scope :is_diagnostic, -> {where c_type: 1000}

  self.per_page = 20
  WillPaginate.per_page = 10

  TYPE_LIST = [['BLOGS', 100], ['PRODUCTS', 200],  ['DIAGNOSTIC_DETOX', 1000]]

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
