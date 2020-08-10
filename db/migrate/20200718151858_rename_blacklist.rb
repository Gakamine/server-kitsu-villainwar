class RenameBlacklist < ActiveRecord::Migration[6.0]
  def change
    rename_table :blacklist, :blacklists
  end
end
