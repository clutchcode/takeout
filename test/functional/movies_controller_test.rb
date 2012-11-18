require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post :create, movie: { alt_title: @movie.alt_title, imdb_id: @movie.imdb_id, overview: @movie.overview, rating: @movie.rating, released: @movie.released, runtime: @movie.runtime, sort_title: @movie.sort_title, tagline: @movie.tagline, title: @movie.title, url: @movie.url }
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie
    assert_response :success
  end

  test "should update movie" do
    put :update, id: @movie, movie: { alt_title: @movie.alt_title, imdb_id: @movie.imdb_id, overview: @movie.overview, rating: @movie.rating, released: @movie.released, runtime: @movie.runtime, sort_title: @movie.sort_title, tagline: @movie.tagline, title: @movie.title, url: @movie.url }
    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

    assert_redirected_to movies_path
  end
end
