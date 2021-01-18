class FantasyLeague < ActiveRecord::Migration[6.0]
  def change
    create_table :fantasyleague_votes do |t|
      t.string   :username, null: false
      t.integer   :user_id, null: false
      t.integer   :score, default: 0
      t.references :villain_1, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_2, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_3, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_4, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_5, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_6, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_7, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_8, foreign_key: { to_table: 'opponents' }, null: false
      t.references :villain_9, foreign_key: { to_table: 'opponents' }, null: false
      t.references :best_villain, foreign_key: { to_table: 'opponents' }, null: false
    end
  end
end
