class AddPriceToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :price, :float
    add_column :adverts, :price_type, :string
  end
end
