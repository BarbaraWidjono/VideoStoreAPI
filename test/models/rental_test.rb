require "test_helper"

describe Rental do
  let(:rental_one) {rentals(:one)}

  it "must be valid" do
    value(rental_one).must_be :valid?
  end
end
