class AddNameToProfile < ActiveRecord::Migration
  def change
    unless column_exists? :profiles, :name
      add_column :profiles, :name, :string
    end
  end
end
