require "test_helper"
require 'pry'
describe Movie do
  let (:blacksmith) {movies(:one)}
  let(:person) {customers(:curran)}


  it "must be valid" do
    value(blacksmith).must_be :valid?
  end

  it "requires title, release_date" do
    required_fields = [:title, :release_date]

    required_fields.each do |field|
      blacksmith[field] = nil

      expect(blacksmith.valid?).must_equal false
      blacksmith.reload
    end
  end


  it "requires title, to be unique" do
    repeat = Movie.new(
      title: Movie.first.title,
      overview: "This is awesome",
      release_date: "2018-11-02",
      inventory: 10
    )
    # Act
    is_valid = repeat.valid?

    # Assert
    expect(is_valid).must_equal false
    expect(repeat.errors.messages).must_include :title
  end


  it "movie has many rentals" do
    rental = Rental.new(customer_id: person.id, movie_id: blacksmith.id)
    expect(rental.customer_id).must_equal person.id
    expect(rental.movie_id).must_equal blacksmith.id
    expect(rental).must_be_kind_of Rental


  end


end
