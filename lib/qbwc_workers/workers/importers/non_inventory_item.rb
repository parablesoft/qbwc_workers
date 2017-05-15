class QbwcWorkers::Workers::Importers::NonInventoryItem < QbwcWorkers::Workers::Importers::BaseImporter

  self.request = [QbwcWorkers::Requests::NonInventoryItemImport.request]
  self.result ="item_non_inventory_ret"

end
