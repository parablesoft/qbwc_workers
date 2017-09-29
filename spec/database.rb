ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :customers do |t|
    t.string :name
    t.string :qb_id
    t.string :billing_address_1
    t.string :billing_address_2
    t.string :billing_city
    t.string :billing_state
    t.string :billing_zip
    t.string :phone
    t.string :email
    t.string :tax_code
    t.string :sales_tax_name
  end


  create_table :sales_tax_code_ret do |t|
    t.string :name
    t.string :qb_id
  end


  create_table :sales_tax_code do |t|
    t.string :name
    t.string :qb_id
  end

  create_table :sales_tax_item do |t|
    t.string :name
    t.string :qb_id
    t.decimal :rate, precision: 6, scale: 3
  end

  create_table :qb_customers do |t|
    t.string :name
    t.string :qb_id
  end

  create_table :qb_products do |t|
    t.string :name
    t.string :qb_id
  end
end

class QbProduct < ActiveRecord::Base

end

class SalesTaxCode < ActiveRecord::Base

end

class Customer < ActiveRecord::Base
end

class QbCustomer < ActiveRecord::Base

end

class SalesTaxCodeConfigInModel < ActiveRecord::Base
  self.table_name="sales_tax_code"

  def self.qbwc_worker_import_config
    {
      name: ["name"],
      qb_id: ["list_id"],
    }
  end
end

class SalesTaxItemConfigInModel < ActiveRecord::Base
  self.table_name="sales_tax_item"

  def self.qbwc_worker_import_config
    {
      name: ["name"],
      qb_id: ["list_id"],
      rate: ["tax_rate"]
    }
  end
end


class CustomerConfigInModel < ActiveRecord::Base
  self.table_name="customers"

  def self.qbwc_worker_import_config
    {
      name: ["name"],
      billing_address_1: ["bill_address","addr1"],
      email: ["email"],
      phone: ["phone"],
      tax_code: ["sales_tax_code_ref","full_name"],
      sales_tax_name: ["item_sales_tax_ref","full_name"]
    }
  end
end
