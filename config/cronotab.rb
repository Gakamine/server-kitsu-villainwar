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
      looser=opp_2
    else
      winner=opp_2
      looser=opp_1
    end

    RestClient.put("https://api.challonge.com/v1/tournaments/kitsu_villainwar/matches/"+current_round.challonge_id.to_s+".json", {
      'api_key': 'api-key',
      'match' => {
        'scores_csv': results_opp1.to_s+'-'+results_opp2.to_s,
        'winner_id': winner.challonge_id
      }
    })

    if current_round.round_number!=Round.all.order('round_number DESC')[0].round_number-3 && current_round.round_number!=Round.all.order('round_number DESC')[0].round_number-2 && current_round.round_number<Round.all.order('round_number DESC')[0].round_number-1
      update_round=ActiveRecord::Base.connection.execute("SELECT * FROM rounds WHERE (opp_1_id IS NULL OR opp_2_id IS NULL) ORDER BY date ASC")[0]
      round = Round.find(update_round['id'])
      if update_round['opp_1_id']==nil
        round.opp_1_id = Opponent.find(winner.id)
        round.save
      else
        round.opp_2_id = Opponent.find(winner.id)
        round.save
      end
    elsif current_round.round_number==Round.all.order('round_number DESC')[0].round_number-3 || current_round.round_number==Round.all.order('round_number DESC')[0].round_number-2
        looser_round=Round.find(Round.all.order('round_number DESC')[0].round_number-1)
        winner_round=Round.find(Round.all.order('round_number DESC')[0].round_number)
        if looser_round['opp_1_id']==nil
          looser_round.opp_1_id = Opponent.find(looser.id)
          looser_round.save
        else
          looser_round.opp_2_id = Opponent.find(looser.id)
          looser_round.save
        end
        if winner_round['opp_1_id']==nil
          winner_round.opp_1_id = Opponent.find(winner.id)
          winner_round.save
        else
          winner_round.opp_2_id = Opponent.find(winner.id)
          winner_round.save
        end
    end

    if current_round.round_number<Round.all.order('round_number DESC')[0].round_number-1
      score=1
      offset=Round.all.order('round_number DESC')[0].round_number/2
      min_round=Round.all.order('round_number DESC')[0].round_number/2
      while min_round<current_round.round_number
        score=score*2
        min_round=min_round+offset/2
        offset=offset/2
      end
      fantasy_list=FantasyleagueVote.where(villain_1_id: looser.id).or(FantasyleagueVote.where(villain_2_id: looser.id)).or(FantasyleagueVote.where(villain_3_id: looser.id)).or(FantasyleagueVote.where(villain_4_id: looser.id)).or(FantasyleagueVote.where(villain_5_id: looser.id)).or(FantasyleagueVote.where(villain_6_id: looser.id)).or(FantasyleagueVote.where(villain_7_id: looser.id)).or(FantasyleagueVote.where(villain_8_id: looser.id)).or(FantasyleagueVote.where(villain_9_id: looser.id))
      for user in fantasy_list
        user.score=user.score+score
        user.save
      end
      fantasy_list=FantasyleagueVote.where(best_villain_id: looser.id)
      for user in fantasy_list
        user.score=user.score+score*2
        user.save
      end    
    elsif current_round.round_number==Round.all.order('round_number DESC')[0].round_number-1
      score=Round.all.order('round_number DESC')[0].round_number
      fantasy_list=FantasyleagueVote.where(villain_1_id: winner.id).or(FantasyleagueVote.where(villain_2_id: winner.id)).or(FantasyleagueVote.where(villain_3_id: winner.id)).or(FantasyleagueVote.where(villain_4_id: winner.id)).or(FantasyleagueVote.where(villain_5_id: winner.id)).or(FantasyleagueVote.where(villain_6_id: winner.id)).or(FantasyleagueVote.where(villain_7_id: winner.id)).or(FantasyleagueVote.where(villain_8_id: winner.id)).or(FantasyleagueVote.where(villain_9_id: winner.id))
      for user in fantasy_list
        user.score=user.score+score
        user.save
      end
      fantasy_list=FantasyleagueVote.where(best_villain_id: winner.id)
      for user in fantasy_list
        user.score=user.score+score*2
        user.save
      end
    else 
      score_w=Round.all.order('round_number DESC')[0].round_number*3
      score_l=Round.all.order('round_number DESC')[0].round_number*2
      fantasy_list=FantasyleagueVote.where(villain_1_id: winner.id).or(FantasyleagueVote.where(villain_2_id: winner.id)).or(FantasyleagueVote.where(villain_3_id: winner.id)).or(FantasyleagueVote.where(villain_4_id: winner.id)).or(FantasyleagueVote.where(villain_5_id: winner.id)).or(FantasyleagueVote.where(villain_6_id: winner.id)).or(FantasyleagueVote.where(villain_7_id: winner.id)).or(FantasyleagueVote.where(villain_8_id: winner.id)).or(FantasyleagueVote.where(villain_9_id: winner.id))
      for user in fantasy_list
        user.score=user.score+score_w
        user.save
      end
      fantasy_list=FantasyleagueVote.where(best_villain_id: winner.id)
      for user in fantasy_list
        user.score=user.score+score_w*2
        user.save
      end
      fantasy_list=FantasyleagueVote.where(villain_1_id: looser.id).or(FantasyleagueVote.where(villain_2_id: looser.id)).or(FantasyleagueVote.where(villain_3_id: looser.id)).or(FantasyleagueVote.where(villain_4_id: looser.id)).or(FantasyleagueVote.where(villain_5_id: looser.id)).or(FantasyleagueVote.where(villain_6_id: looser.id)).or(FantasyleagueVote.where(villain_7_id: looser.id)).or(FantasyleagueVote.where(villain_8_id: looser.id)).or(FantasyleagueVote.where(villain_9_id: looser.id))
      for user in fantasy_list
        user.score=user.score+score_l
        user.save
      end
      fantasy_list=FantasyleagueVote.where(best_villain_id: looser.id)
      for user in fantasy_list
        user.score=user.score+score_l*2
        user.save
      end 
    end

  end
end

Crono.perform(UpdateJob).every 30.seconds#1.day, at: {hour: 23, min: 59}

