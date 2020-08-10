class Vote < ApplicationRecord
    # belongs_to :round
    # belongs_to :opponents
    validates :user_id, :uniqueness => {:scope => [:rounds_id], message: " already voted"}
end