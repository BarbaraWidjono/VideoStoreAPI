class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: customerify(customers), status: :ok
  end



  def show
    customer_id = params[:id]
    customer = Customer.find_by(id: customer_id)
    if customer
      render json: customerify(customer), status: :ok
    else
      render_error(:not_found, {customer_id: ["No such Customer"]})
    end
  end


  private

  def customerify(customer_data)
    return customer_data.as_json(only: [:id, :name, :registered_at, :postal_code, :phone])
  end


  # def customerify_show(customer_data)
  #   return customer_data.as_json(only: [:title, :overview, :release_date, :inventory])
  # end

end
