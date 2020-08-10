module Types
    class RoundType < Types::BaseObject
        description "Rounds information"
        field :id, Integer, null:false
        field :opp_1_id, Types::OpponentType, null:true
        field :opp_2_id, Types::OpponentType, null:false
        field :date_start, String, null:false
        field :date_end, String, null:false
        field :results_opp1, Integer, null:true
        field :results_opp2, Integer, null:true
    end
end 