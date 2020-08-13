class Opponent < ApplicationRecord
    has_one_attached :image
    has_many :rounds
end