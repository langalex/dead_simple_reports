class CreateDeadSimpleReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.column :name, :string
      t.column :code, :text
      t.column :kind, :text
    end
  end

  def self.down
    drop_table :reports
  end
end
