module Types
  class MutationType < Types::BaseObject

    field :submit_vote, mutation: Mutations::SubmitVote
    
  end
end
