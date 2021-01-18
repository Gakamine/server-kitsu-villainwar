module Types
    class RoundType < Types::BaseObject
        description "Rounds information"
        field :id, Integer, null:false
        field :opp_1_id, Types::OpponentType, null:true
        field :opp_2_id, Types::OpponentType, null:false
        field :date, String, null:false
        field :round_number, Integer, null:false
    end
end 