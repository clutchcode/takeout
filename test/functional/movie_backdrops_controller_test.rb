require 'test_helper'

class MovieBackdropsControllerTest < ActionController::TestCase
  setup do
    @movie_backdrop = movie_backdrops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_backdrops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_backdrop" do
    assert_difference('MovieBackdrop.count') do
      post :create, movie_backdrop: { height: @movie_backdrop.height, size: @movie_backdrop.size, url: @movie_backdrop.url, width: @movie_backdrop.width }
    end

    assert_redirected_to movie_backdrop_path(assigns(:movie_backdrop))
  end

  test "should show movie_backdrop" do
    get :show, id: @movie_backdrop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_backdrop
    assert_response :success
  end

  test "should update movie_backdrop" do
    put :update, id: @movie_backdrop, movie_backdrop: { height: @movie_backdrop.height, size: @movie_backdrop.size, url: @movie_backdrop.url, width: @movie_backdrop.width }
    assert_redirected_to movie_backdrop_path(assigns(:movie_backdrop))
  end

  test "should destroy movie_backdrop" do
    assert_difference('MovieBackdrop.count', -1) do
      delete :destroy, id: @movie_backdrop
    end

    assert_redirected_to movie_backdrops_path
  end
end
