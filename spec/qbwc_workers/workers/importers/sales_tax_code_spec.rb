require 'spec_helper'

RSpec.describe QbwcWorkers::Workers::Importers::SalesTaxCode do
  subject{QbwcWorkers::Workers::Importers::SalesTaxCode.new}



  describe "#requests" do
    it{expect(subject.requests(nil,nil,nil)).to match [QbwcWorkers::Requests::SalesTaxCodeImport.request]}
  end


 
  describe "#handle_response" do
    context "config in model" do
      before do
	QbwcWorkers::Configuration.configure do |config|
	  config.import_map = [{worker: "SalesTaxCode", model: "SalesTaxCodeConfigInModel", config_in_model: true}]
	end
	import_records("sales_tax_code")
      end

      it{expect(SalesTaxCodeConfigInModel.count).to eq 2}

      context "first customer" do
	before do
	  import_records("sales_tax_code")
	end

	let(:item) {SalesTaxCodeConfigInModel.first}
	let(:expected) do
	  {
	    "id"=>item.id,
	    "name"=>"Tax",
	    "qb_id"=>"80000001-1465501463",
	  } 
	end
	it "imports the right attributes based on the model config" do
	  expect(item.as_json).to match expected
	end


      end
    end
  end
 
end
