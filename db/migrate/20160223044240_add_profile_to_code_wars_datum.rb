class AddProfileToCodeWarsDatum < ActiveRecord::Migration
  def change

    add_reference :code_wars_data, :profile, index: true

  end
end
