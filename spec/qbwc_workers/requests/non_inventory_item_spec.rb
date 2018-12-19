require 'spec_helper'

RSpec.describe QbwcWorkers::Requests::NonInventoryItemImport do

  let(:expected) do
    {
      :item_non_inventory_query_rq => {
      }
    }
  end

  it{expect(QbwcWorkers::Requests::NonInventoryItemImport.request).to match expected}
end
