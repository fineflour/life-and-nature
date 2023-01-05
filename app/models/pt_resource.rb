class PtResource < ActiveRecord::Base
  self.table_name = "pt_resources"

  CATEGORY = ['DIET','VITAMIN', 'HERB', 'EXERCISE']
  self.per_page = 20
  WillPaginate.per_page = 10


  def self.article_by_menu_id(menu_id)
    query = self.where(:menu_id => menu_id)
    query = query.where(active: true)
    query = query.order('id desc')
#    binding.pry
    query
  end
end


