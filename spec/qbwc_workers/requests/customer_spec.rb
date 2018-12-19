require 'spec_helper'

RSpec.describe QbwcWorkers::Requests::CustomerImport do

  let(:expected) do
    {
      :customer_query_rq => {
      }
    }
  end

  it{expect(QbwcWorkers::Requests::CustomerImport.request).to match expected}
end
