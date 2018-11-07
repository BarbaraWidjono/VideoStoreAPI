
































































































































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
