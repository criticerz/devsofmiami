class AddLatestGithubActivtyToProfiles < ActiveRecord::Migration
  def change

    add_column :profiles, :latest_github_activity_at, :datetime

  end
end
