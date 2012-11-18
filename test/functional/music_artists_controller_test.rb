require 'test_helper'

class MusicArtistsControllerTest < ActionController::TestCase
  setup do
    @music_artist = music_artists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_artists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_artist" do
    assert_difference('MusicArtist.count') do
      post :create, music_artist: { mbid: @music_artist.mbid, name: @music_artist.name, overview: @music_artist.overview }
    end

    assert_redirected_to music_artist_path(assigns(:music_artist))
  end

  test "should show music_artist" do
    get :show, id: @music_artist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_artist
    assert_response :success
  end

  test "should update music_artist" do
    put :update, id: @music_artist, music_artist: { mbid: @music_artist.mbid, name: @music_artist.name, overview: @music_artist.overview }
    assert_redirected_to music_artist_path(assigns(:music_artist))
  end

  test "should destroy music_artist" do
    assert_difference('MusicArtist.count', -1) do
      delete :destroy, id: @music_artist
    end

    assert_redirected_to music_artists_path
  end
end
