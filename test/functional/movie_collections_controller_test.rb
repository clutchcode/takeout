require 'test_helper'

class MovieCollectionsControllerTest < ActionController::TestCase
  setup do
    @movie_collection = movie_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_collection" do
    assert_difference('MovieCollection.count') do
      post :create, movie_collection: { backdrop_url: @movie_collection.backdrop_url, name: @movie_collection.name, poster_url: @movie_collection.poster_url }
    end

    assert_redirected_to movie_collection_path(assigns(:movie_collection))
  end

  test "should show movie_collection" do
    get :show, id: @movie_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_collection
    assert_response :success
  end

  test "should update movie_collection" do
    put :update, id: @movie_collection, movie_collection: { backdrop_url: @movie_collection.backdrop_url, name: @movie_collection.name, poster_url: @movie_collection.poster_url }
    assert_redirected_to movie_collection_path(assigns(:movie_collection))
  end

  test "should destroy movie_collection" do
    assert_difference('MovieCollection.count', -1) do
      delete :destroy, id: @movie_collection
    end

    assert_redirected_to movie_collections_path
  end
end
