class QbwcWorkers::Workers::Importers::SalesTaxCode < QbwcWorkers::Workers::Importers::BaseImporter

  self.request = [QbwcWorkers::Requests::SalesTaxCodeImport.request]
  self.result ="sales_tax_code_ret"

end
