require 'test_helper'

class MovieCreditsControllerTest < ActionController::TestCase
  setup do
    @movie_credit = movie_credits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_credits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_credit" do
    assert_difference('MovieCredit.count') do
      post :create, movie_credit: { character: @movie_credit.character, department: @movie_credit.department, job: @movie_credit.job, name: @movie_credit.name, order: @movie_credit.order, profile: @movie_credit.profile }
    end

    assert_redirected_to movie_credit_path(assigns(:movie_credit))
  end

  test "should show movie_credit" do
    get :show, id: @movie_credit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_credit
    assert_response :success
  end

  test "should update movie_credit" do
    put :update, id: @movie_credit, movie_credit: { character: @movie_credit.character, department: @movie_credit.department, job: @movie_credit.job, name: @movie_credit.name, order: @movie_credit.order, profile: @movie_credit.profile }
    assert_redirected_to movie_credit_path(assigns(:movie_credit))
  end

  test "should destroy movie_credit" do
    assert_difference('MovieCredit.count', -1) do
      delete :destroy, id: @movie_credit
    end

    assert_redirected_to movie_credits_path
  end
end
