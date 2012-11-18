require 'test_helper'

class MovieMembersControllerTest < ActionController::TestCase
  setup do
    @movie_member = movie_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_member" do
    assert_difference('MovieMember.count') do
      post :create, movie_member: { name: @movie_member.name }
    end

    assert_redirected_to movie_member_path(assigns(:movie_member))
  end

  test "should show movie_member" do
    get :show, id: @movie_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie_member
    assert_response :success
  end

  test "should update movie_member" do
    put :update, id: @movie_member, movie_member: { name: @movie_member.name }
    assert_redirected_to movie_member_path(assigns(:movie_member))
  end

  test "should destroy movie_member" do
    assert_difference('MovieMember.count', -1) do
      delete :destroy, id: @movie_member
    end

    assert_redirected_to movie_members_path
  end
end
