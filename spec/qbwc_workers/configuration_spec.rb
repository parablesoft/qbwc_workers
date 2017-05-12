require 'spec_helper'

RSpec.describe QbwcWorkers::Configuration do
  subject {QbwcWorkers::Configuration.new}

  it{expect(subject).to respond_to :import_map}



end
