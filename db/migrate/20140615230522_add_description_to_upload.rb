class AddDescriptionToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :description, :text
  end
end
