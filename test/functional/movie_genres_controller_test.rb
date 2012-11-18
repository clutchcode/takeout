require 'test_helper'

class MovieGenresControllerTest < ActionController::TestCase
  setup do
    @movie_genre = movie_genres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_genres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_genre" do
    assert_difference('MovieGenre.count') do
      post :create, movie_genre: { name: @movie_genre.name }
    end

    assert_redirected_to movie_genre_path(assigns(:movie_genre))
  end

  test "should show movie_genre" do
    get :show, id: @movie_genre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_genre
    assert_response :success
  end

  test "should update movie_genre" do
    put :update, id: @movie_genre, movie_genre: { name: @movie_genre.name }
    assert_redirected_to movie_genre_path(assigns(:movie_genre))
  end

  test "should destroy movie_genre" do
    assert_difference('MovieGenre.count', -1) do
      delete :destroy, id: @movie_genre
    end

    assert_redirected_to movie_genres_path
  end
end
