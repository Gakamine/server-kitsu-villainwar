class RenamingColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :rounds, :start, :date_start
    rename_column :rounds, :end, :date_end
  end
end
