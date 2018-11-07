require "test_helper"

describe RentalsController do
  describe 'create' do

    let(:cust_one) {customers(:shelly)}
    let(:movie_one) {movies(:one)}
    let(:info) {{"customer_id" => cust_one.id, "movie_id" => movie_one.id}}

    it 'will create a rental with valid customer and movie data' do

      expect{post checkout_path, params: info}.must_change('Rental.count', +1)

    end

    it 'will render a bad_request for an invalid rental request' do
      fake_movie_id = "999xxxx999xxx9x9x"
      rental = {
        "customer_id": cust_one.id,
        "movie_id": fake_movie_id
      }

      post checkout_path, params: rental
      must_respond_with :bad_request
    end

    it 'a valid rental will increment the customers movies_checked_out_count' do

        post checkout_path, params: info
        # This reloads the yaml file with the new changes to the variable specified. In this example, it reloaded cust_one data with the changes after checkout_path occurred
        cust_one.reload

        expect(cust_one.movies_checked_out_count).must_equal 1
    end

    it 'an invalid rental will not increment the customers movies_checked_out_count' do

      fake_movie_id = "999xxxx999xxx9x9x"
      rental = {
        "customer_id": cust_one.id,
        "movie_id": fake_movie_id
      }

      start_count = cust_one.movies_checked_out_count

      post checkout_path, params: rental

      cust_one.reload

      end_count = cust_one.movies_checked_out_count
      expect(start_count).must_equal end_count
    end

    it 'will decrament the movies available_inventory with a valid rental' do
      start_availability = movie_one.available_inventory

      post checkout_path, params: info
      movie_one.reload

      expect(movie_one.available_inventory).must_equal (start_availability - 1)
      must_respond_with :success
    end

    it 'will not decrament the movies available_inventory with an invalid rental' do
      start_availability = movie_one.available_inventory

      fake_cust_id = "999xxxx999xxx9x9x"
      rental = {
        "customer_id": fake_cust_id,
        "movie_id": movie_one.id
      }

      post checkout_path, params: rental
      movie_one.reload

      end_availablity = movie_one.available_inventory

      expect(start_availability).must_equal end_availablity
    end
  end
end
