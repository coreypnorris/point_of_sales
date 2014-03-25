class RenameProductsSales < ActiveRecord::Migration
  def change
    rename_table :products_sales, :goods
    add_column :goods, :quantity, :int
  end
end
