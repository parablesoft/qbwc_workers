class QbwcWorkers::Workers::Importers::ServiceItem < QbwcWorkers::Workers::Importers::BaseImporter

  self.request = [QbwcWorkers::Requests::ServiceItemImport.request]
  self.result ="item_service_ret"

end
