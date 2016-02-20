require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { bio: @profile.bio, blog: @profile.blog, company: @profile.company, email: @profile.email, followers: @profile.followers, following: @profile.following, hireable: @profile.hireable, location: @profile.location, name: @profile.name, public_gists: @profile.public_gists, public_repos: @profile.public_repos, username: @profile.username }
    end

    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profile" do
    patch :update, id: @profile, profile: { bio: @profile.bio, blog: @profile.blog, company: @profile.company, email: @profile.email, followers: @profile.followers, following: @profile.following, hireable: @profile.hireable, location: @profile.location, name: @profile.name, public_gists: @profile.public_gists, public_repos: @profile.public_repos, username: @profile.username }
    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_redirected_to profiles_path
  end
end
