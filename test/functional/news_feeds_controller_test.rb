require 'test_helper'

class NewsFeedsControllerTest < ActionController::TestCase
  setup do
    login_as(:yoda)
    @news_feed = news_feeds(:yoda_feed)
    @empty_feed = news_feeds(:empty_feed)
  end

  test "should show news_feed" do
    get :show, :id => @news_feed.to_param
    assert_response :success
  end

  test "should not show other user's feed" do
    get :show, :id => @empty_feed.to_param
    assert_redirected_to news_feed_path(@news_feed)
  end

  test "should get edit" do
    get :edit, :id => @news_feed.to_param
    assert_response :success
  end

  test "should not edit other user's feed" do
    get :edit, :id => @empty_feed.to_param
    assert_redirected_to news_feed_path(@news_feed)
  end

  test "should update news_feed" do
    put :update, :id => @news_feed.to_param, :news_feed => @news_feed.attributes
    assert_redirected_to news_feed_path(assigns(:news_feed))
  end

  test "should not update other user's feed" do
    put :update, :id => @empty_feed.to_param, :empty_feed => @empty_feed.attributes
    assert_redirected_to news_feed_path(@news_feed)
  end
end
