class CreateFlipperV2Tables < ActiveRecord::Migration
  def self.up
    create_table :flipper_keys do |t|
      t.string :key, null: false
      t.string :value, null: false
      t.timestamps null: false
    end
    add_index :flipper_keys, :key, unique: true
  end

  def self.down
    drop_table :flipper_keys
  end
end
