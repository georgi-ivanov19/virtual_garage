class AddCarIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :car_id, :integer
  end
end
