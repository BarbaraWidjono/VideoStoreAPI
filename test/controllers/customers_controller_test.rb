require "test_helper"

describe CustomersController do
  describe 'index' do
    it 'should get index' do
      get customers_path
      must_respond_with :success
    end

    it "returns json" do
      get customers_path
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "returns an Array" do
      get customers_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
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
      non_existant_cust_id = "99999xxxxxxxxxx9999"
      get customer_path(non_existant_cust_id)
      must_respond_with :not_found
    end
  end
end
