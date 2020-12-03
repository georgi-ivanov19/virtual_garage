class ChangeCarDescriptionToText < ActiveRecord::Migration[5.2]
  def up
    change_column :cars, :description, :text
  end

  def def down 
    change_column :cars, :description, :string
  end
end
