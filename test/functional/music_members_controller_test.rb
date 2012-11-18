require 'test_helper'

class MusicMembersControllerTest < ActionController::TestCase
  setup do
    @music_member = music_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_member" do
    assert_difference('MusicMember.count') do
      post :create, music_member: { name: @music_member.name }
    end

    assert_redirected_to music_member_path(assigns(:music_member))
  end

  test "should show music_member" do
    get :show, id: @music_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_member
    assert_response :success
  end

  test "should update music_member" do
    put :update, id: @music_member, music_member: { name: @music_member.name }
    assert_redirected_to music_member_path(assigns(:music_member))
  end

  test "should destroy music_member" do
    assert_difference('MusicMember.count', -1) do
      delete :destroy, id: @music_member
    end

    assert_redirected_to music_members_path
  end
end
