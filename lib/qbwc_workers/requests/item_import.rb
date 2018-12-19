class QbwcWorkers::Requests::ItemImport < QbwcWorkers::Requests::BaseImport
  self.query  =[
    {
      :item_service_query_rq  =>{
      }
    },
    {
      :item_non_inventory_query_rq  =>{
      }
    }
  ]

end
