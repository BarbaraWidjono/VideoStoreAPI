require "test_helper"

describe CustomersController do
  describe 'index' do
    it 'should get index' do
      get customers_path
      must_respond_with :success
    end
  end

  describe 'show' do

    before do
      @customer = Customer.first
    end

    it 'will show an existing customer' do

      get customer_path(@customer.id)
      must_respond_with :success
    end

    it 'will render a status not_found for a non-existant customer' do
      destroyed_customer = @customer.destroy
      destroyed_customer.save
      get customer_path(destroyed_customer.id)
      must_respond_with :not_found
    end
  end
end
