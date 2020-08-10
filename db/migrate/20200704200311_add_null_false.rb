class AddNullFalse < ActiveRecord::Migration[6.0]
  def change
    change_column :votes, :rounds_id, :integer, null: false
    change_column :votes, :opponents_id, :integer, null: false
  end
end
