module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :current_round, RoundType, null: true do
      description "Show current round information"
    end
    def current_round
      Round.where("date = ? ",Time.now)[0]
    end

  end
end
