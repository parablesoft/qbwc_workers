class QbwcWorkers::Workers::Customer < QbwcWorkers::Workers::Base

  def requests(job, session, data)
    [QbwcWorkers::Requests::Customer.request]
  end


  def handle_response(r, session, job, request, data)
    import_data(r["customer_ret"])
  end


end
