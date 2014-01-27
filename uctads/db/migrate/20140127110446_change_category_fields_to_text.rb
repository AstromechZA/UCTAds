class ChangeCategoryFieldsToText < ActiveRecord::Migration
  def change
    change_column :categories, :fields, :text
  end
end
