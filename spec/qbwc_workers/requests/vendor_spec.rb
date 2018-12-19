require 'spec_helper'

RSpec.describe QbwcWorkers::Requests::VendorImport do

  let(:expected) do
    {
      :vendor_query_rq => {
      }
    }
  end

  it{expect(QbwcWorkers::Requests::VendorImport.request).to match expected}
end
