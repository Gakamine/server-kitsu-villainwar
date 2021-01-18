class Round < ApplicationRecord
    # has_many :votes
    belongs_to :opp_1_id, :class_name => "Opponent", :foreign_key => "opp_1_id", optional: true
    belongs_to :opp_2_id, :class_name => "Opponent", :foreign_key => "opp_2_id", optional: true
end