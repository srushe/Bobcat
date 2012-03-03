class RemoveMachineTagsMigration < ActiveRecord::Migration
  def self.up
    drop_table :taggings
    drop_table :tags
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't restore the machine tags tables"
  end
end
