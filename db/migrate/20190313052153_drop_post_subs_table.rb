class DropPostSubsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :post_subs
  end
end
