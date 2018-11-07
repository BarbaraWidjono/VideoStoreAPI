require "test_helper"

describe RentalsController do
  describe 'create' do

    let(:cust_one) {customers(:shelly)}
    let(:movie_one) {movies(:one)}

    it 'will create a rental with valid customer and movie data' do
      rental = {
        rental: {
          customer: cust_one.id,
          movie: movie_one.id
        }
      }

      expect{post rentals_path, params: rental}.must_change('Rental.count', +1)
    end

  end
end
