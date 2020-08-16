class FantasyleagueVote < ApplicationRecord
    validates :user_id, :uniqueness => {:scope => [:user_id], message: " already voted"}
end