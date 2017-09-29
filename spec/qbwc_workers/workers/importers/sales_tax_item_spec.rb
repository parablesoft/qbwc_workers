require 'spec_helper'

RSpec.describe QbwcWorkers::Workers::Importers::SalesTaxItem do

  subject{QbwcWorkers::Workers::Importers::SalesTaxItem.new}


  describe "#requests" do
    it{expect(subject.requests(nil,nil,nil)).to match [QbwcWorkers::Requests::SalesTaxItemImport.request]}
  end


  describe "#handle_response" do
    context "config in model" do
      before do
	QbwcWorkers::Configuration.configure do |config|
	  config.import_map = [{worker: "SalesTaxItem", model: "SalesTaxItemConfigInModel", config_in_model: true}]
	end
	import_records("sales_tax_item")
      end

      it{expect(SalesTaxItemConfigInModel.count).to eq 4}

      context "first customer" do
	before do
	  import_records("sales_tax_item")
	end

	let(:item) {SalesTaxItemConfigInModel.first}
	let(:expected) do
	  {
	    "id"=>item.id,
	    "name"=>"Bay",
	    "qb_id"=>"8000000A-1494675509",
	    "rate"=>6.5,
	  } 
	end
	it "imports the right attributes based on the model config" do
	  expect(item.as_json).to match expected
	end


      end
    end
  end
 
end
