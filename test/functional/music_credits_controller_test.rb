require 'test_helper'

class MusicCreditsControllerTest < ActionController::TestCase
  setup do
    @music_credit = music_credits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_credits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_credit" do
    assert_difference('MusicCredit.count') do
      post :create, music_credit: { credit: @music_credit.credit, department: @music_credit.department, job: @music_credit.job }
    end

    assert_redirected_to music_credit_path(assigns(:music_credit))
  end

  test "should show music_credit" do
    get :show, id: @music_credit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_credit
    assert_response :success
  end

  test "should update music_credit" do
    put :update, id: @music_credit, music_credit: { credit: @music_credit.credit, department: @music_credit.department, job: @music_credit.job }
    assert_redirected_to music_credit_path(assigns(:music_credit))
  end

  test "should destroy music_credit" do
    assert_difference('MusicCredit.count', -1) do
      delete :destroy, id: @music_credit
    end

    assert_redirected_to music_credits_path
  end
end
