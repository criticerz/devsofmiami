class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :name
      t.string :company
      t.string :blog
      t.string :location
      t.boolean :hireable
      t.string :email
      t.string :bio
      t.integer :public_repos
      t.integer :public_gists
      t.integer :followers
      t.integer :following

      t.timestamps null: false
    end
  end
end
