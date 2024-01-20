class PtResource < ActiveRecord::Base
  include PgSearch::Model


  has_many :blog_categories
  has_many :categories, through: :blog_categories

  pg_search_scope :text_search, against: [:title, :body]
  scope :by_category_id, -> (category_id) { joins(:blog_categories).where(blog_categories: {category_id: category_id})}
  scope :category, -> (category) { where(pt_resources: {category: category})}

  self.table_name = "pt_resources"

  CATEGORY_LIST = [['HOLISTIC THEAPY', 100], ['DIET', 200],['EXERCISE', 300], ['HERB', 400], ['SUPPLEMENTS', 500], ['CANCER', 600],
                   ['CHOLESTEROL', 700]], 

  self.per_page = 20
  WillPaginate.per_page = 20


  def self.getArticleList(menu_id)
    query = self.where(:menu_id => menu_id)
    query = query.where(active: true)
    query = query.order('id desc').limit(10)
    query
  end

  def self.by_date
    query = self.where(active: true)
    query = query.order('created_at DESC')
    query
  end

  def self.getMenues
    arr = []
    menu_values ||= YAML.load((File.open("#{Rails.root}/config/menues.yml", 'r')))
    for n in menu_values
      arr <<  [n["name"], n["id"]] 
    end
    arr
  end

end
