class RemoveImageFieldsFromCar < ActiveRecord::Migration[5.2]
  def up
    remove_column :cars, :image_file_name
    remove_column :cars, :image_content_type
    remove_column :cars, :image_file_size
    remove_column :cars, :image_updated_at
  end

  def down
    add_column :cars, :image_file_name
    add_column :cars, :image_content_type
    add_column :cars, :image_file_size
    add_column :cars, :image_updated_at
  end
end
