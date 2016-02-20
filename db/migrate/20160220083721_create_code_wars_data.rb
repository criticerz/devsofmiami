class CreateCodeWarsData < ActiveRecord::Migration
  def change
    create_table :code_wars_data do |t|
      t.string :username
      t.string :honor
      t.string :languages

      t.timestamps null: false
    end
  end
end
