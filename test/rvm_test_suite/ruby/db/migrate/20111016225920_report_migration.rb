class ReportMigration < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.references :command
      t.string  :cmd
      t.text  :cmd_output
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
