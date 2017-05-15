require 'spec_helper'

RSpec.describe QbwcWorkers::Workers::Importers::Customer do
  subject{QbwcWorkers::Workers::Importers::Customer.new}


  describe "#requests" do
    it{expect(subject.requests(nil,nil,nil)).to match [QbwcWorkers::Requests::CustomerImport.request]}
  end


  describe "#handle_response" do

    context "default configuration" do
      it "imports the customers" do
	import_records("customers")
	expect(Customer.count).to eq 6
      end

      it "does not import the customers twice" do
	import_records("customers")
	expect(Customer.count).to eq 6
	import_records("customers")
	expect(Customer.count).to eq 6
      end

      context "first customer" do
	before do
	  import_records("customers")
	end

	let(:customer) {Customer.first}
	it{expect(customer.name).to eq("ACME Widgets")}
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
	import_records
      end

      it{expect(QbCustomer.count).to eq 6}

    end


    context "config in model" do
      before do
	QbwcWorkers::Configuration.configure do |config|
	  config.import_map = [{worker: "Customer", model: "CustomerConfigInModel", config_in_model: true}]
	end
	import_records
      end

      it{expect(CustomerConfigInModel.count).to eq 6}

      context "first customer" do
	before do
	  import_records
	end



	let(:customer) {Customer.first}
	let(:expected) do
	  {
	    "id"=>customer.id,
	    "name"=>"ACME Widgets",
	    "qb_id"=>"80000008-1483639220",
	    "billing_address_1"=>"1234 Anywhere Lane",
	    "billing_address_2"=>nil,
	    "billing_city"=>nil,
	    "billing_state"=>nil,
	    "billing_zip"=>nil,
	    "phone"=>"813-555-1212",
	    "tax_code"=>"Tax",
	    "sales_tax_name"=>"Florida",
	    "email"=>"bob@example.com"
	  } 
	end
	it "imports the right attributes based on the model config" do
	  expect(customer.as_json).to match expected
	end


      end
    end
  end



end
