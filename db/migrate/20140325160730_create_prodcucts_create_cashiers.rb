class CreateProdcuctsCreateCashiers < ActiveRecord::Migration
  def change
    create_table :prodcucts do |t|
      t.column :name, :string
      t.column :cost, :float

      t.timestamps
    end

    create_table :cashiers do |t|
      t.column :name, :string

      t.timestamps
    end

    create_table :sales do |t|
      t.column :cashier_id, :int
      t.column :product_id, :int

      t.timestamps
    end
  end
end
