require 'rest-client'

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

    field :check_vote, Integer, null: true do
      description "Check if user already voted"
      argument :token, String, required: true
    end
    def check_vote(token:)
      round=Round.where("date = ? ",Time.now)[0]
      response = RestClient.get("https://kitsu.io/api/edge/users?filter[self]=true", {'Authorization': 'Bearer '+token})
      if defined?(JSON.parse(response.body)['data'][0]['id'])
        if Vote.where(rounds_id: round.id, user_id: JSON.parse(response.body)['data'][0]['id']).count >= 1
          return 1
        else
          return 0
        end
      else
        return 0
      end
    end

  end
end
