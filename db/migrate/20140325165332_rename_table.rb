class RenameTable < ActiveRecord::Migration
  def change
    rename_table :prodcucts, :products
  end
end
