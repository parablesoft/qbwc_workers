require 'spec_helper'

RSpec.describe QbwcWorkers::Workers::Importers::NonInventoryItem do
  subject{QbwcWorkers::Workers::Importers::NonInventoryItem.new}



  it "imports the products" do
    import_records("non_inventory_items")
    expect(QbProduct.count).to eq 3
  end



end
