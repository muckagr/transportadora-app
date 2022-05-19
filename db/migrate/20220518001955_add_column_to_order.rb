class AddColumnToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :track_id, :string
  end
end
