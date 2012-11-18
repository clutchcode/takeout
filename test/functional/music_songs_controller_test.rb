require 'test_helper'

class MusicSongsControllerTest < ActionController::TestCase
  setup do
    @music_song = music_songs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_songs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_song" do
    assert_difference('MusicSong.count') do
      post :create, music_song: { bitrate: @music_song.bitrate, channle_mode: @music_song.channle_mode, file_uri: @music_song.file_url, length: @music_song.length, part: @music_song.part, sample_rate: @music_song.sample_rate, set: @music_song.set, title: @music_song.title, track: @music_song.track, vbr: @music_song.vbr }
    end

    assert_redirected_to music_song_path(assigns(:music_song))
  end

  test "should show music_song" do
    get :show, id: @music_song
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_song
    assert_response :success
  end

  test "should update music_song" do
    put :update, id: @music_song, music_song: { bitrate: @music_song.bitrate, channle_mode: @music_song.channle_mode, file_uri: @music_song.file_url, length: @music_song.length, part: @music_song.part, sample_rate: @music_song.sample_rate, set: @music_song.set, title: @music_song.title, track: @music_song.track, vbr: @music_song.vbr }
    assert_redirected_to music_song_path(assigns(:music_song))
  end

  test "should destroy music_song" do
    assert_difference('MusicSong.count', -1) do
      delete :destroy, id: @music_song
    end

    assert_redirected_to music_songs_path
  end
end
