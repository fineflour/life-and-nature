class PagesController < ApplicationController
  def sitemap
    @posts =  PtResource.all.by_date
  end
end
