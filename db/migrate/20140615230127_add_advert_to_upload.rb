class AddAdvertToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :advert_id, :integer
  end
end
