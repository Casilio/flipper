require 'rubygems'
require 'bundler'
Bundler.setup(:default)
require 'rails'
require 'rails/test_help'

begin
  ActiveSupport::TestCase.test_order = :random
rescue NoMethodError => boom
  # no biggie, means we are on older version of AS that doesn't have this option
end

require 'active_record'
require 'rails/generators/test_case'
require 'generators/flipper/active_record_v2_generator'

class FlipperActiveRecordV2GeneratorTest < Rails::Generators::TestCase
  tests Flipper::Generators::ActiveRecordV2Generator
  destination File.expand_path("../../../../tmp", __FILE__)
  setup :prepare_destination

  def test_generates_migration
    run_generator
    assert_migration "db/migrate/create_flipper_tables.rb", <<-EOM
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
EOM
  end
end
