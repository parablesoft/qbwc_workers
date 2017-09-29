class QbwcWorkers::Workers::Importers::SalesTaxItem < QbwcWorkers::Workers::Importers::BaseImporter

  self.request = [QbwcWorkers::Requests::SalesTaxItemImport.request]
  self.result ="item_sales_tax_ret"

end
