class QuestionsAndAnswer < ApplicationRecord
    self.per_page = 20
    WillPaginate.per_page = 10

end
