# require 'qbwc'
require "hashie"
class QbwcWorkers::Workers::Base# < QBWC::Worker

  def config
    @config ||= QbwcWorkers::Configuration.configuration
  end

  def import_map
    @import_map ||= self.config.import_map
  end

  def worker_class_name
    @worker_class_name ||= self.class.name.split("::").last
  end

  def import_map_item
    @import_map_item ||= self.import_map.find{|map_item| map_item[:worker] == worker_class_name}
  end

  def import_map_fields
    @import_map_fields ||= self.import_map_item[:fields]
  end

  def import_model
    @import_model ||= import_map_item[:model].constantize
  end


  private
  def import_data(data)
    data.each do |item|
      import_item(item)
    end
  end

  def import_item(item)
    import_item = item.extend Hashie::Extensions::DeepFetch
    qb_id = item["list_id"]

    create_params = {}
    import_map_fields.each_pair do |key, value|
      create_params[key] = import_item.deep_fetch(*value) {|k| nil}
    end

    self.import_model.create_with(create_params).find_or_create_by(qb_id: qb_id)
  end
end
