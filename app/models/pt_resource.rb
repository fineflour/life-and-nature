class PtResource < ActiveRecord::Base
  self.table_name = "pt_resources"

  CATEGORY_LIST = ['ACUPUNCTURE', 'DIET','VITAMIN', 'HERB', 'EXERCISE']
  MENU_LIST = [['Home', 100], ['Acupuncture', 201], ['Holistic Therapy', '200'], 
   ['Detox & Balance' , 202], ['Health Tests', 208], ['Facial Care', 205], ['Oncology Supportive Care', '206'],
   ['Homeopathy & Natural Supplements', 207],
   ['Chronic & Severe Pain', 301], ['Neurological Disorders', 302], ['Mood & Emotional Disorders', 303], ['Autoimmune Disorders', 304], ['Digestsive Disorders', 305], ['Oncology Supportive Care', 306], ['Women''s Health', 307], ['Children''s Health', 308],

   ['Skin Conditions', 309], ['Men''s Health', 310], ['Addictions', 311], ['Digestive Disorders', 312], ['Patient Resources', 400]]



 










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


