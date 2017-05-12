module QbwcWorkers
  class Configuration

    attr_accessor :import_map


    CUSTOMER_IMPORT_MAP = {
      name: ["name"],
      billing_address_1: ["bill_address","addr1"],
      billing_address_2: ["bill_address","addr2"],
      billing_city: ["bill_address","city"],
      billing_state: ["bill_address","state"],
      billing_zip: ["bill_address","postal_code"]
    }


    def initialize
      self.import_map = [{worker: "Customer", model:"Customer", fields: CUSTOMER_IMPORT_MAP}]
    end

    class << self
      attr_accessor :configuration
    end

    @configuration ||= Configuration.new

    def self.configure
      yield(@configuration)
    end
  end
end
