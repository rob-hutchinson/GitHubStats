class EditUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_id, :string
    add_column :users, :auth_data, :text
  end
end
