require 'test_helper'

class MusicCategoriesControllerTest < ActionController::TestCase
  setup do
    @music_category = music_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_category" do
    assert_difference('MusicCategory.count') do
      post :create, music_category: {  }
    end

    assert_redirected_to music_category_path(assigns(:music_category))
  end

  test "should show music_category" do
    get :show, id: @music_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_category
    assert_response :success
  end

  test "should update music_category" do
    put :update, id: @music_category, music_category: {  }
    assert_redirected_to music_category_path(assigns(:music_category))
  end

  test "should destroy music_category" do
    assert_difference('MusicCategory.count', -1) do
      delete :destroy, id: @music_category
    end

    assert_redirected_to music_categories_path
  end
end
