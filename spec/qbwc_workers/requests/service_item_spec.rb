require 'spec_helper'

RSpec.describe QbwcWorkers::Requests::ServiceItemImport do

  let(:expected) do
    {
      :item_service_query_rq => {
      }
    }
  end

  it{expect(QbwcWorkers::Requests::ServiceItemImport.request).to match expected}
end
