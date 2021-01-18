class AddCheckedBlacklist < ActiveRecord::Migration[6.0]
  def change
    add_column :blacklists, :checked, :boolean, default: 0
  end
end
