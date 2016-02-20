class CreateProfileLanguages < ActiveRecord::Migration
  def change
    create_table :profile_languages do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :language, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
