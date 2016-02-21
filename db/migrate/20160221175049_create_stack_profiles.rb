class CreateStackProfiles < ActiveRecord::Migration
  def change
    create_table :stack_profiles do |t|
      t.string :display_name
      t.integer :reputation
      t.string :location
      t.references :user, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
