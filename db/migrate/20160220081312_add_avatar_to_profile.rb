class AddAvatarToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :avatar_url, :string
  end
end
