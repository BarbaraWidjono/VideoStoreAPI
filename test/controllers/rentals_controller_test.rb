require "test_helper"

describe RentalsController do
  describe 'create' do

    let(:cust_one) {customers(:shelly)}
    let(:movie_one) {movies(:one)}

    it 'will create a rental with valid customer and movie data' do
       info =
       {
          "customer_id" => cust_one.id,
          "movie_id" => movie_one.id
        }

      expect{post checkout_path, params: info}.must_change('Rental.count', +1)

    end

    it 'a valid rental will increment the customers movies_checked_out_count' do
       info =
       {
          "customer_id" => cust_one.id,
          "movie_id" => movie_one.id
        }
        post checkout_path, params: info
        # This reloads the yaml file with the new changes to the variable specified. In this example, it reloaded cust_one data with the changes after checkout_path occurred
        cust_one.reload

        expect(cust_one.movies_checked_out_count).must_equal 1
    end
  end
end
