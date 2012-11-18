require 'test_helper'

class MusicImagesControllerTest < ActionController::TestCase
  setup do
    @music_image = music_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_image" do
    assert_difference('MusicImage.count') do
      post :create, music_image: { aspect_ratio: @music_image.aspect_ratio, height: @music_image.height, image_type: @music_image.image_type, language: @music_image.language, size: @music_image.size, sort_order: @music_image.sort_order, source: @music_image.source, url: @music_image.url, width: @music_image.width }
    end

    assert_redirected_to music_image_path(assigns(:music_image))
  end

  test "should show music_image" do
    get :show, id: @music_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_image
    assert_response :success
  end

  test "should update music_image" do
    put :update, id: @music_image, music_image: { aspect_ratio: @music_image.aspect_ratio, height: @music_image.height, image_type: @music_image.image_type, language: @music_image.language, size: @music_image.size, sort_order: @music_image.sort_order, source: @music_image.source, url: @music_image.url, width: @music_image.width }
    assert_redirected_to music_image_path(assigns(:music_image))
  end

  test "should destroy music_image" do
    assert_difference('MusicImage.count', -1) do
      delete :destroy, id: @music_image
    end

    assert_redirected_to music_images_path
  end
end
