require "test_helper"

describe Rental do
  let(:shelly) {rentals(:one)}

  it "must be valid" do
    value(shelly).must_be :valid?
  end
end
