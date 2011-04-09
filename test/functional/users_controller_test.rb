require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @yoda = users(:yoda)

    # for creation from user input
    @vader = {
      :email => 'dvader@empire.mil',
      :password => 'YourLackOfFaith123',
      :password_confirmation => 'YourLackOfFaith123',
      :feed_url => 'https://github.com/dvader.private.atom?token=not-a-token'
    }
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => @vader
    end

    assert_redirected_to news_feed_path(assigns(:user).news_feed)
  end

  test "should not create user with missing feed url" do
    tauntaun = {
      :email => "tauntaun@hoth.net",
      :password => 'yaaaaaaaaaaaaarg',
      :password_confirmation => 'yaaaaaaaaaaaaarg'
    }

    assert_no_difference('User.count') do
      post :create, :user => tauntaun
    end

    assert_select '#error_explanation ul li', /News feed can't be blank/
  end

  test "should not create user with invalid email address" do
    obiwan = {
      :email => "what is this I don't even",
      :password => 'not.these.droids',
      :password_confirmation => 'not.these.droids',
      :feed_url => 'https://github.com/obiwan.private.atom?token=not-a-token'
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
      :password_confirmation => 'oh.that.one',
      :feed_url => 'https://github.com/luke.private.atom?token=not-a-token'
    }
    assert_no_difference('User.count') do
      post :create, :user => luke
    end

    assert_select '#error_explanation ul li', /Password doesn't match confirmation/
  end

  test "should update user" do
    update = {
      :email => 'yoda@dagobah.net',
      :feed_url => 'https://github.com/yodanew.private.atom?token=new'
    }
    put :update, :id => @yoda.to_param, :user => update
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @yoda.to_param
    end

    assert_redirected_to users_path
  end
end
