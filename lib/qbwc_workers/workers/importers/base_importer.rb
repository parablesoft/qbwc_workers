require "hashie"
# require "qbwc"
class QbwcWorkers::Workers::Importers::BaseImporter #< QBWC::Worker

  LIST_ID = "list_id"

  class_attribute :request
  class_attribute :result

  def requests(job, session, data)
    request
  end


  def handle_response(response, session, job, request, data)
    import_data(response[result])
  end

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
    @import_map_fields ||= get_import_map_fields
  end

  def get_import_map_fields
    return nil if self.import_map_item.nil?
    if self.import_map_item[:config_in_model]
      import_model.qbwc_worker_import_config
    else
      self.import_map_item[:fields]
    end

  end

  def import_model
    @import_model ||= import_map_item ? import_map_item[:model].constantize : nil
  end



  private
  def import_data(data)
    data.each {|item| import_item(item)}
  end


  def import_item(item)
    item_params = {}
    import_item = item.extend Hashie::Extensions::DeepFetch

    return if import_map_fields.nil?

    import_map_fields.each_pair do |key, value|
      item_params[key] = import_item.deep_fetch(*value) {|k| nil}
    end

    existing = self.import_model.find_by(qb_id: item[LIST_ID])

    if existing
      existing.update_attributes(item_params)
    else
      self.import_model.create_with(item_params).find_or_create_by!(qb_id: item[LIST_ID])
    end

  end


end
