require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get login page" do
    get :new
    assert_response :success
  end

  test "should login with good credentials" do
    user = User.new(:email => 'foo@bar.com',
                    :password => 'bad',
                    :password_confirmation => 'bad',
                    :feed_url => 'https://github.com/foo.private.atom?token=nah')
    user.save

    post :create, :email => 'foo@bar.com', :password => 'bad'
    assert_redirected_to news_feed_path(user.news_feed)
  end

  test "should not login with bad credential" do
    post :create, :email => 'nope@no-way.com', :password => 'fuggitaboudit'
    assert_redirected_to login_url
  end

  test "should be able to logout" do
    get :destroy
    assert_redirected_to :root
  end

end
