class AddTwitterToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_uid, :string
    add_column :users, :twitter_oauth_token, :string
    add_column :users, :twitter_oauth_secret, :string
    add_column :users, :twitter_oauth_expires_at, :datetime
  end
end
