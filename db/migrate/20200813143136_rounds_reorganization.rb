class RoundsReorganization < ActiveRecord::Migration[6.0]
  def change
    remove_column :rounds, :date_start
    remove_column :rounds, :date_end
    remove_column :rounds, :results_opp1
    remove_column :rounds, :results_opp2
    add_column :rounds, :date, :date
  end
end
