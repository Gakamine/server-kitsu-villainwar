require 'rest-client'

class Mutations::FantasyleagueVote < Mutations::BaseMutation
    argument :token, String, required: true
    argument :villain_ids, [String], required: true
    argument :best_villain, Integer, required: true

    field :vote, Types::VoteType, null: true
    field :errors, [String], null: false

    def resolve(token:, villain_ids:, best_villain:)
        puts villain_ids[0]
        response = RestClient.get("https://kitsu.io/api/edge/users?filter[self]=true", {'Authorization': 'Bearer '+token})
        if defined?(JSON.parse(response.body)['data'][0]['id'])
            userid = JSON.parse(response.body)['data'][0]['id']
            username = JSON.parse(response.body)['data'][0]['attributes']['name']
            #The user is authenticated
            if(Round.where("date > ?",Time.now).count==Round.all.count)
                vote = FantasyleagueVote.new(
                    user_id: userid,
                    username: username,
                    villain_1_id: villain_ids[0],
                    villain_2_id: villain_ids[1],
                    villain_3_id: villain_ids[2],
                    villain_4_id: villain_ids[3],
                    villain_5_id: villain_ids[4],
                    villain_6_id: villain_ids[5],
                    villain_7_id: villain_ids[6],
                    villain_8_id: villain_ids[7],
                    villain_9_id: villain_ids[8],
                    best_villain_id: best_villain
                )
                #We create the vote
                if vote.save
                    {
                        vote: vote,
                        errors: []
                    }
                #We reply with a error in case something went wrong
                else
                    {
                        vote: nil,
                        errors: vote.errors.full_messages
                    }
                end
            else
                {
                    vote: nil,
                    errors: ["The fantasy league is closed "]
                }
            end
        else
            #The user is not authenticated or his token is incorrect
            {
                vote: nil,
                errors: ["Invalid token"]
            }
        end
    end

end