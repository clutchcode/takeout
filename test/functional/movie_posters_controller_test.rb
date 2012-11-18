require 'test_helper'

class MoviePostersControllerTest < ActionController::TestCase
  setup do
    @movie_poster = movie_posters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_posters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_poster" do
    assert_difference('MoviePoster.count') do
      post :create, movie_poster: { height: @movie_poster.height, size: @movie_poster.size, url: @movie_poster.url, width: @movie_poster.width }
    end

    assert_redirected_to movie_poster_path(assigns(:movie_poster))
  end

  test "should show movie_poster" do
    get :show, id: @movie_poster
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_poster
    assert_response :success
  end

  test "should update movie_poster" do
    put :update, id: @movie_poster, movie_poster: { height: @movie_poster.height, size: @movie_poster.size, url: @movie_poster.url, width: @movie_poster.width }
    assert_redirected_to movie_poster_path(assigns(:movie_poster))
  end

  test "should destroy movie_poster" do
    assert_difference('MoviePoster.count', -1) do
      delete :destroy, id: @movie_poster
    end

    assert_redirected_to movie_posters_path
  end
end
