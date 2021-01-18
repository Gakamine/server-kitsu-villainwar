module Types
  class MutationType < Types::BaseObject

    field :submit_vote, mutation: Mutations::SubmitVote
    field :submit_fantasyleague_vote, mutation: Mutations::FantasyleagueVote
    
  end
end
