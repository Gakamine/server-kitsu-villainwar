require 'rest-client'


class Mutations::SubmitVote < Mutations::BaseMutation

    argument :token, String, required: true
    argument :opp_id, Integer, required: true

    field :vote, Types::VoteType, null: true
    field :errors, [String], null: false
    
    def resolve(token:, opp_id:)

        response = RestClient.get("https://kitsu.io/api/edge/users?filter[self]=true", {'Authorization': 'Bearer '+token})
        if defined?(JSON.parse(response.body)['data'][0]['id'])
            userid = JSON.parse(response.body)['data'][0]['id']
            #The user is authenticated
            
            currentRound = Round.where("date = ?",Time.now)[0].id

            if(Round.find(currentRound).opp_1_id.id==opp_id || Round.find(currentRound).opp_2_id.id==opp_id)
                vote = Vote.new(user_id: userid, opponents_id: opp_id, rounds_id: currentRound)
                #We create the vote
                anticheat(response,userid)
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
                    errors: ["Invalid opponent id"]
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

    def anticheat(response,userid)
        verified_email=!JSON.parse(response.body)['data'][0]['attributes']['confirmed']
        date_creation=Date.parse(JSON.parse(response.body)['data'][0]['attributes']['createdAt'])>Round.order('date').limit(1)[0].date
        number_entries=!(JSON.parse(response.body)['data'][0]['attributes']['ratingsCount']>10)
        username=JSON.parse(response.body)['data'][0]['attributes']['name']
        pfp=JSON.parse(response.body)['data'][0]['attributes']['avatar']==nil
        if verified_email || date_creation || number_entries || pfp
            blacklisted=Blacklist.new(user_id: userid, username: username, acc_non_verified_email: verified_email, acc_too_recent: date_creation, acc_not_enough_entries: number_entries, acc_default_pfp: pfp)
            blacklisted.save
        end
    end

end