require "test_helper"

describe Customer do
  let(:customer) { Customer.new }

  # it "must be valid" do
  #   value(customer).must_be :valid?
  # end
  describe 'relations' do
    it 'a customer can have many rentals' do
      customer = Customer.first
      movie_1 = Movie.first
      movie_2 = Movie.last

      current_rental_count = Rental.where(customer_id: customer.id).count

      rental_1 = Rental.create(customer_id: customer.id, movie_id: movie_1.id)
      rental_2 = Rental.create(customer_id: customer.id, movie_id: movie_2.id)
      rentals = Rental.where(customer_id: customer.id).count

      expect(rentals).must_equal (current_rental_count + 2)
    end
  end

  describe 'validations' do
    before do
      @customer = Customer.new(
        name: "PotatoHead",
        registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
        postal_code: "98103",
        phone: "(206)222-2222"
      )
    end

    it 'is valid when name, registered_at, postal_code and phone are present' do
      is_valid = @customer.valid?
      expect(is_valid).must_equal true
    end

    it 'is invalid without name' do
      @customer.name = nil

      is_valid = @customer.valid?
      expect(is_valid).must_equal false
      expect(@customer.errors.messages).must_include :name
    end

    it 'is invalid without registered_at' do
      @customer.registered_at = nil

      is_valid = @customer.valid?
      expect(is_valid).must_equal false
      expect(@customer.errors.messages).must_include :registered_at
    end

    it 'is invalid without postal_code' do
      @customer.postal_code = nil

      is_valid = @customer.valid?
      expect(is_valid).must_equal false
      expect(@customer.errors.messages).must_include :postal_code
    end

    it 'is invalid without phone' do
      @customer.phone = nil

      is_valid = @customer.valid?
      expect(is_valid).must_equal false
      expect(@customer.errors.messages).must_include :phone
    end
  end
end
