class Opponent < ApplicationRecord
    has_one_attached :image
    # belongs_to :opp_1_id, :class_name => "Round", :foreign_key => "opp_1_id"
    # belongs_to :opp_2_id, :class_name => "Round", :foreign_key => "opp_2_id"
end