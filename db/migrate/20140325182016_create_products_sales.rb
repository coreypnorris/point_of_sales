class CreateProductsSales < ActiveRecord::Migration
  def change
    create_table :products_sales do |t|
      t.column :sale_id, :int
      t.column :product_id, :int

      t.timestamps
    end

    rename_column :sales, :product_id, :customer_id

    create_table :customers do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end
