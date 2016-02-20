class AddChallengesCompletedToCodeWarsData < ActiveRecord::Migration
  def change
    add_column :code_wars_data, :challenges_completed, :string
  end
end
