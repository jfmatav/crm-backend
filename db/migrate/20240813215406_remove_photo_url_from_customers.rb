class RemovePhotoUrlFromCustomers < ActiveRecord::Migration[7.2]
  def change
    remove_column :customers, :photo_url
  end
end
