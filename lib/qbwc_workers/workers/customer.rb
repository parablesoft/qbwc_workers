# require 'qbwc'
class QbwcWorkers::Workers::Customer# < QBWC::Worker

  def requests(job, session, data)
    [QbwcWorkers::Requests::Customer.request]
  end


  def handle_response(r, session, job, request, data)
    import_customers(r["customer_ret"])
  end

  private
  def import_customers(data)
    data.each do |item|
      import_customer(item)
    end
  end

  def import_customer(item)
    qb_id = item["list_id"]

    create_params = {name: item["name"]}

    if item["bill_address"] 
      billing = item["bill_address"]
      create_params.merge!(
	billing_address_1: billing["addr1"],
	billing_address_2: billing["addr2"],
	billing_city: billing["city"],
	billing_state: billing["state"],
	billing_zip: billing["postal_code"],
      )
    end

    Customer.create_with(create_params).find_or_create_by(qb_id: qb_id)
  end
end
