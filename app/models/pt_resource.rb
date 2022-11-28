class PtResource < ApplicationRecord

    CATEGORY = ['DIET','VITAMIN', 'HERB', 'EXERCISE']
    self.per_page = 20
    WillPaginate.per_page = 10
end
