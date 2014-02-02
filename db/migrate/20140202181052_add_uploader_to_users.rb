class AddUploaderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uploader, :string
  end
end
