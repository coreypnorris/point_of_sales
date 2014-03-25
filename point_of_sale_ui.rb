require 'active_record'

require './lib/cashier'
require './lib/product'
require './lib/customer'
require './lib/sale'


database_configurations = YAML::load(File.open("./db/config.yml"))
development_configuration = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the To Do list!"
  login_menu
end

def login_menu
  puts "Press 'A' for admin."
  puts "Press 'C' for cashier."
  puts "Press 'X' to exit"

  choice = gets.chomp.upcase
  case choice
  when 'A'
    admin_menu
  when 'C'
    cashier_menu
  when 'X'
    puts "Goodbye!"
  else
    puts "Invalid input"
    login_menu
  end
end

def admin_menu
  choice = nil
  until choice == 'X'
    puts "Press 'C' to add a cashier"
    puts "Press 'P' to add a product"
    puts "Press 'LC' to list all cashiers"
    puts "Press 'LP' to list all products"
    puts "Press 'X' to exit system"
    choice = gets.chomp.upcase

    case choice
    when "C"
      add_cashier
    when "P"
      add_product
    when "LC"
      list_cashiers
    when "LP"
      list_products
    when "X"
      puts "Goodbye"
    else
      puts "Not a valid input"
      admin_menu
    end
  end
end

def add_cashier
  puts "Enter your cashier's name:"
  new_name = gets.chomp
  new_cashier = Cashier.create(:name => new_name)
  puts "You added #{new_cashier.name} with an id of #{new_cashier.id}"
end

def add_product
  puts "Enter the new product's name:"
  product_name = gets.chomp
  puts "Enter the cost of the new product:"
  product_cost = gets.chomp.to_f
  new_product = Product.create(:name => product_name, :cost => product_cost)
  puts "you added #{new_product.name} with a cost of $#{new_product.cost}"
end

def list_cashiers
  system "clear"
  puts "List of all cashiers:"
  Cashier.all.reorder('name').each do |cashier|
    puts "#{cashier.name} ID: #{cashier.id}"
  end
end

def list_products
  system "clear"
  puts "List of all products:"
  Product.all.reorder('name').each do |product|
    puts "#{product.name} Cost: $#{product.cost} ID: #{product.id}"
  end
end




def cashier_menu
  puts "Enter your name:"
  cashier_name = gets.chomp
  puts "Enter your employee id:"
  employee_id = gets.chomp.to_i
  cashier = Cashier.find_by(:name => cashier_name)
  if cashier.id == employee_id
    sale_menu(cashier)
  else
    puts "you entered the wrong employee id:"
    cashier_menu
  end
end

def sale_menu(cashier)
  puts "#{cashier.name} is now the active cashier"
  puts "Enter the Customer name:"
  new_customer = Customer.create(:name => gets.chomp)
  new_sale = Sale.create(:cashier_id => cashier.id, :customer_id => new_customer.id)
  add_product_to_sale(new_sale)
end

def add_product_to_sale(sale)
  current_sale = sale
  list_products
  puts "choose a product by id to add:"
  current_product = Product.find_by(:id => gets.chomp.to_i)
  current_sale.products << current_product
  puts "Would you like to add another product? Y/N"
  choice = gets.chomp.upcase

  case choice
  when "Y"
    add_product_to_sale(current_sale)
  when "N"
    puts "entire transaction for #{current_sale.customer.name}"
    current_sale.products.each do |product|
      puts "#{product.name} cost: $#{product.cost}"
    end
  end
end
welcome






