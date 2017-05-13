class QbwcWorkers::Workers::Importers::Customer < QbwcWorkers::Workers::Importers::BaseImporter

  self.request = [QbwcWorkers::Requests::CustomerImport.request]
  self.result ="customer_ret"

end
