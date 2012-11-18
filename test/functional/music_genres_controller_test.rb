require 'test_helper'

class MusicGenresControllerTest < ActionController::TestCase
  setup do
    @music_genre = music_genres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_genres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_genre" do
    assert_difference('MusicGenre.count') do
      post :create, music_genre: { name: @music_genre.name }
    end

    assert_redirected_to music_genre_path(assigns(:music_genre))
  end

  test "should show music_genre" do
    get :show, id: @music_genre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_genre
    assert_response :success
  end

  test "should update music_genre" do
    put :update, id: @music_genre, music_genre: { name: @music_genre.name }
    assert_redirected_to music_genre_path(assigns(:music_genre))
  end

  test "should destroy music_genre" do
    assert_difference('MusicGenre.count', -1) do
      delete :destroy, id: @music_genre
    end

    assert_redirected_to music_genres_path
  end
end
