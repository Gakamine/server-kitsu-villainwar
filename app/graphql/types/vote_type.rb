module Types
    class VoteType < Types::BaseObject
        description "Vote information"
        field :id, Integer, null:false
        field :user_id, Integer, null:false
        field :rounds_id, Integer, null:false
        field :opponents_id, Integer, null:false
    end
end 