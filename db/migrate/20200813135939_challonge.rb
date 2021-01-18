class Challonge < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :challonge_id, :integer
    add_column :opponents, :challonge_id, :integer
  end
end
