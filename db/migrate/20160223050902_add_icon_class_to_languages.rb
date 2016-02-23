class AddIconClassToLanguages < ActiveRecord::Migration
  def change

    add_column :languages, :icon_class, :string

  end
end
