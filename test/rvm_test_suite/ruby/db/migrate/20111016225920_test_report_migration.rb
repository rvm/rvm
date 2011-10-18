class TestReportMigration < ActiveRecord::Migration
  def self.up
    create_table :test_reports do |t|
      t.references :commands
      t.string  :timings
      t.timestamps
    end
  end

  def self.down
    drop_table :test_reports
  end
end
