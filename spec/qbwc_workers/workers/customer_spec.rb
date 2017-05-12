require 'spec_helper'

RSpec.describe QbwcWorkers::Workers::Customer do
  subject{QbwcWorkers::Workers::Customer.new}


  describe "#requests" do
    it{expect(subject.requests(nil,nil,nil)).to match [QbwcWorkers::Requests::Customer.request]}
  end


  describe "#handle_response" do
    def load_customers
      subject.handle_response(load_query("customers"),nil,nil,nil,nil)
    end

    context "default configuration" do
      it "imports the customers" do
	load_customers
	expect(Customer.count).to eq 7
      end

      it "does not import the customers twice" do
	load_customers
	expect(Customer.count).to eq 7
	load_customers
	expect(Customer.count).to eq 7
      end

      context "first customer" do
	before do
	  load_customers
	end

	let(:customer) {Customer.first}
	it{expect(customer.name).to eq("Deco")}
	it{expect(customer.qb_id).to eq "80000008-1483639220"}
	it{expect(customer.billing_address_1).to eq "1234 Anywhere Lane"}
	it{expect(customer.billing_address_2).to eq "Suite B"}
	it{expect(customer.billing_city).to eq "Tampa"}
	it{expect(customer.billing_state).to eq "FL"}
	it{expect(customer.billing_zip).to eq "33601"}

      end
    end

    context "config in initializer" do
      before do
	QbwcWorkers::Configuration.configure do |config|
	  config.import_map = [{worker: "Customer", model: "QbCustomer", fields: {name: ["name"]}}]
	end
	load_customers
      end

      it{expect(QbCustomer.count).to eq 7}

    end


    context "config in initializer" do
      before do
	QbwcWorkers::Configuration.configure do |config|
	  config.import_map = [{worker: "Customer", model: "CustomerConfigInModel", config_in_model: true}]
	end
	load_customers
      end

      it{expect(CustomerConfigInModel.count).to eq 7}

      context "first customer" do
	before do
	  load_customers
	end

	let(:customer) {Customer.first}
	it{expect(customer.name).to eq("Deco")}
	it{expect(customer.qb_id).to eq "80000008-1483639220"}
	it{expect(customer.billing_address_1).to eq "1234 Anywhere Lane"}
	it{expect(customer.billing_address_2).to be_nil}
	it{expect(customer.billing_city).to be_nil}
	it{expect(customer.billing_state).to be_nil}
	it{expect(customer.billing_zip).to be_nil}

      end
    end
  end



end
