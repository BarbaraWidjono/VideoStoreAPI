require "test_helper"

describe MoviesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "return json" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "return an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end


    it "returns pets with exactly the required fields" do
      keys = ["id", "title", "release_date"].sort
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end


  end

end
