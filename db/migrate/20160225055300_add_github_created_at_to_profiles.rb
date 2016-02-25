class AddGithubCreatedAtToProfiles < ActiveRecord::Migration
  def change

    add_column :profiles, :github_created_at, :datetime

  end
end
