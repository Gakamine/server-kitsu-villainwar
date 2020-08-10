class Base < ActiveRecord::Migration[6.0]
  def change

    create_table :opponents do |t|
      t.string :name,               null: false
    end

    create_table :rounds do |t|
      t.integer :round_number,      null: false
      t.references :opp_1,          foreign_key: { to_table: 'opponents' }
      t.references :opp_2,          foreign_key: { to_table: 'opponents' }
      t.datetime :start,            null: false
      t.datetime :end,              null: false
      t.integer :results_opp1,      null: true
      t.integer :results_opp2,      null: true
    end

    create_table :votes do |t|
      t.integer :user_id,           null: false
      t.belongs_to :rounds,         foreign_key: true
      t.belongs_to :opponents,      foreign_key: true
    end

    create_table :blacklist do |t|
      t.integer :user_id,           null: false
      t.boolean :acc_too_recent,    default: false
      t.boolean :acc_not_enough_entries, default: false
      t.boolean :acc_non_verified_email, default: false
      t.boolean :acc_default_pfp, default: false
    end

  end
end
