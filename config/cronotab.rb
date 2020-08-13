# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
require 'rest-client'

class UpdateJob
  def perform
    current_round=Round.where("date = ?",Time.now)[0]
    blacklist=Blacklist.where(acc_too_recent: true).or(Blacklist.where(acc_not_enough_entries: true)).or(Blacklist.where(acc_non_verified_email: true)).or(Blacklist.where(acc_default_pfp: true)).map(&:user_id).uniq
    opp_1=current_round.opp_1_id
    results_opp1=Vote.where(opponents_id: opp_1, rounds_id: current_round).where.not(user_id: blacklist).count
    opp_2=current_round.opp_2_id
    results_opp2=Vote.where(opponents_id: opp_2, rounds_id: current_round).where.not(user_id: blacklist).count
    if results_opp1>results_opp2
      winner=opp_1
    else
      winner=opp_2
    end
    RestClient.put("https://api.challonge.com/v1/tournaments/kitsu_villainwar/matches/"+current_round.challonge_id.to_s+".json", {
      'api_key': 'api-key-here',
      'match' => {
        'scores_csv': results_opp1.to_s+'-'+results_opp2.to_s,
        'winner_id': winner.challonge_id
      }
    })
    update_round=ActiveRecord::Base.connection.execute("SELECT * FROM rounds WHERE (opp_1_id IS NULL OR opp_2_id IS NULL) ORDER BY date ASC")[0]
    round = Round.find(update_round['id'])
    if update_round['opp_1_id']==nil
      round.opp_1_id = Opponent.find(winner.id)
      round.save
    else
      round.opp_2_id = Opponent.find(winner.id)
      round.save
    end
  end
end

Crono.perform(UpdateJob).every 60.seconds

