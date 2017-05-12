require 'spec_helper'

RSpec.describe QbwcWorkers::Requests::Customer do

    let(:expected) do
      {
	:customer_query_rq => {
	}
      }
    end

  it{expect(QbwcWorkers::Requests::Customer.request).to match expected}
end
