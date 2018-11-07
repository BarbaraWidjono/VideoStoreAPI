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


  describe "create" do
    #
  let(:movie_data) {
    {"title" => "Cool Movie", "overview" => "This is awesome", "release_date" => "2018-11-02", "inventory" => 10}
  }

    it "create a new a movie given valid data" do

      expect{
        post movies_path, params: movie_data
      }.must_change "Movie.count", 1

      must_respond_with :success


      body = JSON.parse(response.body)
      movie = Movie.find(body["id"].to_i)


      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      expect(movie.title).must_equal movie_data["title"]

    end




    it "returns an error for invalid movie data" do
      # arrange
      movie_data["title"] = nil

      expect {
        post movies_path, params: { movie: movie_data }
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end

  describe "show" do
    let(:a_movie) {movies(:one)}
    KEYS = ["title", "overview", "release_date", "inventory", "available_inventory"].sort

    it "can get a movie" do
      get movie_path(a_movie.id)
      must_respond_with :success

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body.keys.sort).must_equal KEYS
    end

    it "rendors error not_found, when a movie does not exist" do

      no_movie_id = 33333
      get movie_path(no_movie_id)

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "movie_id"
      must_respond_with :not_found
    end
  end





end
