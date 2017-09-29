module QbwcWorkers
  class Configuration

    attr_accessor :import_map


    CUSTOMER_IMPORT_MAP = {
      name: ["name"]
    }

    CUSTOMER_IMPORT_MAP_BILLING_ADDRESS = {
      billing_address_1: ["bill_address","addr1"],
      billing_address_2: ["bill_address","addr2"],
      billing_city: ["bill_address","city"],
      billing_state: ["bill_address","state"],
      billing_zip: ["bill_address","postal_code"]
    }

    NON_INVENTORY_ITEM_MAP = {
      name: ["name"]
    }


    def initialize
      self.import_map = []
      self.import_map << Configuration.customer_mapping([:billing_address,:contact_information])
      self.import_map << Configuration.non_inventory_item_mapping
    end



    def self.customer_mapping(maps = [])
      fields = {}
      fields.merge! CUSTOMER_IMPORT_MAP
      fields.merge! CUSTOMER_IMPORT_MAP_BILLING_ADDRESS if maps.include?(:billing_address)
      {worker: "Customer", model:"Customer", fields: fields}
    end

    def self.non_inventory_item_mapping
      fields = {}
      fields.merge! NON_INVENTORY_ITEM_MAP
      {worker: "NonInventoryItem", model: "QbProduct", fields: fields}
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
