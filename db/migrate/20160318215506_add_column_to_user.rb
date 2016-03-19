class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text
    add_column :users, :location, :string
    add_column :users, :url, :string
    add_column :users, :birthday, :date
  end
end
