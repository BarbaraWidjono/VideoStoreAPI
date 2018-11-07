

describe RentalsController do
  describe 'create' do

    let(:cust_one) {customers(:shelly)}
    let(:movie_one) {movies(:one)}
    let(:info) {{"customer_id" => cust_one.id, "movie_id" => movie_one.id}}

    it 'will create a rental with valid customer and movie data' do






























































































































  describe " destroy " do

    let(:cust_two) {customers(:dave)}
    let(:movie_two) {movies(:two)}
    let(:cust_three) {customers(:shelly)}

    let(:rental_one) {rentals(:three)}
    it 'will destroy a rental with valid customer and movie data' do
      info =
      {
        "customer_id" => cust_two.id,
        "movie_id" => movie_two.id
      }

      cust_two.reload

      expect{post checkin_path, params: info}.must_change('Rental.count', -1)
    end

    it 'a valid rental will decrement the customers movies_checked_out_count' do
      info =
      {
        "customer_id" => cust_two.id,
        "movie_id" => movie_two.id
      }
      post checkin_path, params: info
      # This reloads the yaml file with the new changes to the variable specified. In this example, it reloaded cust_one data with the changes after checkout_path occurred
      cust_two.reload

      expect(cust_two.movies_checked_out_count).must_equal 4
    end



    it "if rental doesn't exsits it reponds with a message" do
      info =
      {
        "customer_id" => cust_three.id,
        "movie_id" => movie_two.id
      }

      post checkin_path, params: info
      must_respond_with :success
      expect(response.body).must_include "Rental id:  doesn't exist. Try again"
    end

<<<<<<< HEAD
    it "changes the available inventory for the movie when the movie is checked back in" do

      movie = Movie.find_by(id:  movie_two.id)

      info =
      {
        "customer_id" => cust_two.id,
        "movie_id" => movie_two.id
      }

      post checkin_path, params: info
      must_respond_with :success

      movie_two.reload
      cust_two.reload
      expect(movie_two.available_inventory).must_equal 4
      expect(response.body).must_include "Rental id"

    end


  end


end
=======
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

    it 'sets a checkout date and due date for a valid rental' do
      @customer = Customer.create(
        name: "PotatoHead",
        registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
        postal_code: "98103",
        phone: "(206)222-2222"
      )

      info ={
        "customer_id" => @customer.id,
        "movie_id" => movie_one.id
      }

      post checkout_path, params: info
      rental = Rental.find_by(customer_id: @customer.id)

      expect(rental.check_out_date).must_be_kind_of Date
      expect(rental.due_date).must_be_kind_of Date

    end

    it 'sets a due date that is 7 days after the checkout date for a valid rental' do
      @customer = Customer.create(
        name: "PotatoHead",
        registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
        postal_code: "98103",
        phone: "(206)222-2222"
      )

      info ={
        "customer_id" => @customer.id,
        "movie_id" => movie_one.id
      }

      post checkout_path, params: info
      rental = Rental.find_by(customer_id: @customer.id)
      expect(rental.due_date).must_equal (rental.check_out_date + 7)
    end
  end
# end
>>>>>>> 8d5f45d31a85aa7b7c1d7ef16557ce879c2c782e
