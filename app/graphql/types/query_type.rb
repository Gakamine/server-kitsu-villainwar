module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :current_round, RoundType, null: true do
      description "Show current round information"
    end
    def current_round
      Round.where("date_end >= ? AND date_start <= ? ",Time.now,Time.now).order("round_number asc")[0]
    end

    field :get_results, [RoundType], null: false do
      description "Show results"
    end
    def get_results
      Round.all()
    end

  end
end
