class QbwcWorkers::Workers::Importers::Vendor < QbwcWorkers::Workers::Importers::BaseImporter

  self.request = [QbwcWorkers::Requests::VendorImport.request]
  self.result ="vendor_ret"

end
