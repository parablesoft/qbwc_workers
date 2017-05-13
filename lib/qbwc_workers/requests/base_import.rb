class QbwcWorkers::Requests::BaseImport
  class_attribute :query

  def self.request
      self.query
  end

end
