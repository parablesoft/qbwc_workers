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
  end


  create_table :qb_customers do |t|
    t.string :name
    t.string :qb_id
  end
end

class Customer < ActiveRecord::Base
end

class QbCustomer < ActiveRecord::Base

end

class CustomerConfigInModel < ActiveRecord::Base
  self.table_name="customers"


  def self.qbwc_worker_import_config
    {
      name: ["name"],
      billing_address_1: ["bill_address","addr1"],
      email: ["email"],
      phone: ["phone"]
    }
  end
end
