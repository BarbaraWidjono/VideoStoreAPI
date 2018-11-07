require "test_helper"

describe Rental do
  let(:rental_one) {rentals(:one)}

  it "Rental must be valid" do
    value(rental_one).must_be :valid?
  end


  it "rental belongs to customer" do
    expect(rental_one.customer).must_be_kind_of Customer
    expect(rental_one.customer.name).must_equal "Shelly Rocha"
  end

  it "rental belongs to movie" do
    expect(rental_one.movie).must_be_kind_of Movie
    expect(rental_one.movie.title).must_equal "Blacksmith of the Orange"
  end


end
