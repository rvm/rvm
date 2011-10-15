class CommandMigration < ActiveRecord::Migration
  def self.up
    create_table :commands do |t|
      t.string :sysname     
      t.string :os_type
      t.string  :cmd
      t.text  :cmd_output
      t.timestamps
    end
  end

  def self.down
    drop_table :commands
  end
end
