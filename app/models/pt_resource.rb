class PtResource < ActiveRecord::Base

  has_many :blog_categories
  has_many :categories, through: :blog_categories

  self.table_name = "pt_resources"

  CATEGORY_LIST = [['ACUPUNCTURE', 100], ['DIET', 200],['EXERCISE', 300], ['HERB', 400], ['VITAMIN', 500], ['CANCER', 600],
                   ['CHOLESTEROL', 700]]

  self.per_page = 20
  WillPaginate.per_page = 10


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
