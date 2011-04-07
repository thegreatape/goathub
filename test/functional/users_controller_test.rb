require 'test_helper'
require 'pp'

class UsersControllerTest < ActionController::TestCase
  setup do
    @yoda = users(:yoda)

    # for creation from user input
    @vader = {
      :email => 'dvader@empire.mil',
      :password => 'YourLackOfFaith123',
      :password_confirmation => 'YourLackOfFaith123'
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => @vader
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should not create user with invalid email address" do
    obiwan = {
      :email => "what is this I don't even",
      :password => 'not.these.droids',
      :password_confirmation => 'not.these.droids'
    }
    assert_no_difference('User.count') do
      post :create, :user => obiwan
    end

    assert_select '#error_explanation ul li', /Email is invalid/
  end

  test "should not create user with mismatched passwords" do
    luke = {
      :email => 'luke@rebel-alliance.org',
      :password => 'what.wompa?',
      :password_confirmation => 'oh.that.one'
    }
    assert_no_difference('User.count') do
      post :create, :user => luke
    end

    assert_select '#error_explanation ul li', /Password doesn't match confirmation/
  end

  test "should show user" do
    get :show, :id => @yoda.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @yoda.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => @yoda.to_param, :user => @yoda.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @yoda.to_param
    end

    assert_redirected_to users_path
  end
end
